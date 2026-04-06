from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from .models import Robot, Sensors, SensorReadings, Actuators, Control

# ─── AUTH ────────────────────────────────────────────────────────────

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            request.session['username'] = username
            messages.success(request, f'Welcome back, {username}!')
            return redirect('dashboard')
        else:
            messages.error(request, 'Invalid username or password.')
    return render(request, 'login.html')

def logout_view(request):
    logout(request)
    request.session.flush()
    return redirect('login')

# ─── DASHBOARD ───────────────────────────────────────────────────────

@login_required(login_url='login')
def dashboard(request):
    context = {
        'total_robots':   Robot.objects.count(),
        'total_sensors':  Sensors.objects.count(),
        'total_readings': SensorReadings.objects.count(),
        'total_actuators':Actuators.objects.count(),
        'robots':         Robot.objects.all().order_by('robot_id'),
    }
    return render(request, 'dashboard.html', context)

# ─── ROBOTS ──────────────────────────────────────────────────────────

@login_required(login_url='login')
def robots_list(request):
    robots = Robot.objects.all().order_by('robot_id')
    return render(request, 'robots.html', {'robots': robots})

@login_required(login_url='login')
def robot_detail(request, id):
    robot   = get_object_or_404(Robot, robot_id=id)
    sensors = Sensors.objects.filter(robot=robot)
    readings = SensorReadings.objects.filter(
        sensor__robot=robot
    ).select_related('sensor').order_by('-reading_time')
    controls = Control.objects.filter(
        reading__sensor__robot=robot
    ).select_related('reading__sensor', 'actuator')
    return render(request, 'robot_detail.html', {
        'robot':    robot,
        'sensors':  sensors,
        'readings': readings,
        'controls': controls,
    })

@login_required(login_url='login')
def robot_add(request):
    if request.method == 'POST':
        robot_name = request.POST.get('robot_name')
        location   = request.POST.get('location')
        status     = request.POST.get('status')
        Robot.objects.create(
            robot_name=robot_name,
            location=location,
            status=status
        )
        messages.success(request, f'Robot {robot_name} added successfully!')
        return redirect('robots')
    return render(request, 'robot_form.html', {'action': 'Add'})

@login_required(login_url='login')
def robot_edit(request, id):
    robot = get_object_or_404(Robot, robot_id=id)
    if request.method == 'POST':
        robot.robot_name = request.POST.get('robot_name')
        robot.location   = request.POST.get('location')
        robot.status     = request.POST.get('status')
        robot.save()
        messages.success(request, f'Robot {robot.robot_name} updated!')
        return redirect('robots')
    return render(request, 'robot_form.html', {'action': 'Edit', 'robot': robot})

@login_required(login_url='login')
def robot_delete(request, id):
    robot = get_object_or_404(Robot, robot_id=id)
    if request.method == 'POST':
        name = robot.robot_name
        robot.delete()
        messages.success(request, f'Robot {name} deleted!')
        return redirect('robots')
    return render(request, 'robot_confirm_delete.html', {'robot': robot})

# ─── SENSORS ─────────────────────────────────────────────────────────

@login_required(login_url='login')
def sensors_list(request):
    robot_id = request.GET.get('robot_id')
    robots   = Robot.objects.all().order_by('robot_id')
    sensors  = Sensors.objects.select_related('robot').order_by('robot_id', 'sensor_id')
    if robot_id:
        sensors = sensors.filter(robot_id=robot_id)
    return render(request, 'sensors.html', {
        'sensors':          sensors,
        'robots':           robots,
        'selected_robot':   robot_id,
    })

# ─── READINGS ────────────────────────────────────────────────────────

@login_required(login_url='login')
def readings_list(request):
    robot_id  = request.GET.get('robot_id')
    sensor_id = request.GET.get('sensor_id')
    robots    = Robot.objects.all().order_by('robot_id')
    sensors   = Sensors.objects.all()
    readings  = SensorReadings.objects.select_related(
        'sensor', 'sensor__robot'
    ).order_by('-reading_time')

    if robot_id:
        readings = readings.filter(sensor__robot_id=robot_id)
        sensors  = sensors.filter(robot_id=robot_id)
    if sensor_id:
        readings = readings.filter(sensor_id=sensor_id)

    # Flag readings outside min/max
    for r in readings:
        if r.sensor.max_value and r.value > r.sensor.max_value:
            r.status = 'above'
        elif r.sensor.min_value and r.value < r.sensor.min_value:
            r.status = 'below'
        else:
            r.status = 'normal'

    return render(request, 'readings.html', {
        'readings':         readings,
        'robots':           robots,
        'sensors':          sensors,
        'selected_robot':   robot_id,
        'selected_sensor':  sensor_id,
    })

# ─── ACTUATORS ───────────────────────────────────────────────────────

@login_required(login_url='login')
def actuators_list(request):
    actuators = Actuators.objects.all().order_by('actuator_id')
    for a in actuators:
        a.times_triggered = Control.objects.filter(actuator=a).count()
    return render(request, 'actuators.html', {'actuators': actuators})

# ─── CONTROL ─────────────────────────────────────────────────────────

@login_required(login_url='login')
def control_list(request):
    robot_id = request.GET.get('robot_id')
    robots   = Robot.objects.all().order_by('robot_id')
    controls = Control.objects.select_related(
        'reading__sensor__robot', 'actuator'
    ).order_by('-reading__reading_time')

    if robot_id:
        controls = controls.filter(reading__sensor__robot_id=robot_id)

    return render(request, 'control.html', {
        'controls':       controls,
        'robots':         robots,
        'selected_robot': robot_id,
    })

# ─── ERROR PAGES ─────────────────────────────────────────────────────
def custom_404(request, exception):
    return render(request, '404.html', status=404)

def custom_500(request):
    return render(request, '500.html', status=500)