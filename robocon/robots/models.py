from django.db import models

class Robot(models.Model):
    robot_id = models.AutoField(primary_key=True)
    robot_name = models.CharField(max_length=100)
    location = models.CharField(max_length=100, blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'robot'
    def __str__(self):
        return self.robot_name

class Sensors(models.Model):
    sensor_id = models.AutoField(primary_key=True)
    robot = models.ForeignKey(Robot, models.DO_NOTHING, blank=True, null=True)
    sensor_type = models.CharField(max_length=100, blank=True, null=True)
    unit = models.CharField(max_length=50, blank=True, null=True)
    max_value = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    min_value = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'sensors'
    def __str__(self):
        return str(self.sensor_type)

class SensorReadings(models.Model):
    reading_id = models.AutoField(primary_key=True)
    sensor = models.ForeignKey(Sensors, models.DO_NOTHING, blank=True, null=True)
    reading_time = models.DateTimeField(blank=True, null=True)
    value = models.DecimalField(max_digits=10, decimal_places=4, blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'sensor_readings'

class Actuators(models.Model):
    actuator_id = models.AutoField(primary_key=True)
    actuation_type = models.CharField(max_length=100, blank=True, null=True)
    power_consumption = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    placement = models.CharField(max_length=100, blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'actuators'
    def __str__(self):
        return str(self.actuation_type)

class Control(models.Model):
    control_id = models.AutoField(primary_key=True)
    reading = models.ForeignKey(SensorReadings, models.DO_NOTHING, blank=True, null=True)
    actuator = models.ForeignKey(Actuators, models.DO_NOTHING, blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'control'