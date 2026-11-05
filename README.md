# Taste_AI_Flutter_App
- This is a Mobile Application Development and AI course project.
- This project includes a RESTFul Flutter application with a Django Backend.
- We were allowed the use of agents for this project by our course instructor so we did.
- The 2 AI models for the palatte_based folder and calorie_based folder will be uploaded later on to a separate google drive folder because of size restrictions.

## Table of Contents

- [Tools](#tools)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Project Environment](#project-environment)
- [Credits](#credits)

## Tools
- Python
- Django-REST-framework
- Flutter

## Features
- Two AI models in the Django backend that can be found in the recipes app inside the Django parent directory.
- RESTFul View based Django Backend.
- Included requirements.txt for python environment.
- User Accounts and Authentication inside the app using Django's built-in authentication.
- CRUD functionality for a user so that they can manage their own recipes.
- Recommendations based on existing user recipes and user palette.
- Recommendations based on user's macros for losing weight or building muscle.

## Prerequisites
- It is recommended to create a separate python environment for the project by using "py -m venv .env".
- Variables SECRET_KEY, ALLOWED_HOSTS, EMAIL_HOST_USER, EMAIL_HOST_PASSWORD, DEFAULT_FROM_EMAIL have been omitted from settings.py in Django project root. Please use your own when you create the project.
- The Sqlite DB for the Django project has been omitted, so please run the commands "py manage.py makemigrations" and "py manage.py migrate" to rebuild it yourself. You should also create a superuser to access the Django admin panel by using the command "py manage.py createsuperuser".
- The email constants should be repopulated with your own credentials in settings.py so that the Email and reset password functionality can work.
- If your android emulator is not android studio or your android emulator is hosted at a different port, then please modify the port inside settings.py. You can find out your flutter port when you try to run your project.
- Please modify the SECRET_KEY constant inside settings.py and populate it with a newly generated Django secure key.
- Please modify the file paths inside the python driver scripts in both the calorie_based and palatte_based folders inside the recipes directory of the Django project to suit your own desktop system.
- Run "flutter clean", "flutter pub get" and "flutter pub upgrade" inside the flutter project.
- You MUST modify the "static const String baseUrl" inside auth_service.dart and recipe_service.dart so that it matches your own backend IP and port.

## Project Environment
- Run the Django server using "py manage.py runserver 9091" where 9091 is the port I used for the project. You can change this if you want but then you must modify the IP and Port in the flutter project.
- You can run the flutter project using "flutter run" but make sure that you use the correct IP based on the type of application you are compiling. For example, the IP is 10.0.2.2 virtually for flutter code if you use android studio emulator or 127.0.0.1 for Desktop and Web. If you are using your mobile phone instead, then you must make your IP static by going into your router settings and then use the Django server machine's LAN IP instead for the flutter code. 

## Credits
- This project was coded in collaboration with my university group member. GitHub: https://github.com/Hamza2-2
- Dataset sourced from https://www.kaggle.com/datasets/elisaxxygao/foodrecsysv1
