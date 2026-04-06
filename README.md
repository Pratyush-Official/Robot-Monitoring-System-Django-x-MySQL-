# Robot Monitoring System — Django x MySQL

A web application for tracking Robocon robotics club robots across different competition years (2022–2026).

## What it does
- View all robots built for Robocon competitions
- Monitor sensors attached to each robot
- Track sensor readings and flag values outside thresholds
- See which actuators were triggered by sensor readings
- Full CRUD operations for managing robots
- User authentication with login/logout

## Tech Stack
- Python 3.12
- Django 4.2
- MySQL (via XAMPP)
- HTML/CSS

## How to Run
1. Clone the repository
2. Create a virtual environment and activate it
3. Install dependencies: `pip install django mysqlclient`
4. Import `robot_db.sql` into phpMyAdmin
5. Run `python manage.py migrate`
6. Run `python manage.py createsuperuser`
7. Run `python manage.py runserver`
8. Visit `http://127.0.0.1:8000`

## Project Structure
- `robots/models.py` — Database models
- `robots/views.py` — All view logic and CRUD
- `robots/urls.py` — URL routing
- `robots/middleware.py` — Custom logging, security and error handling middleware
- `robots/templates/` — All HTML templates
