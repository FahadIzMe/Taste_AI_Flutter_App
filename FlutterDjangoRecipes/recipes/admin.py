from django.contrib import admin
from .models import Recipes, RecipeIngredients

admin.site.register(Recipes)
admin.site.register(RecipeIngredients)