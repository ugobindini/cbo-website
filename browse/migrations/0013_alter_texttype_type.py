# Generated by Django 4.2.15 on 2024-08-21 15:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('browse', '0012_texttype_texttypespecification_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='texttype',
            name='type',
            field=models.CharField(choices=[('Metrical poetry', 'Metrical poetry'), ('Rhythmical poetry', 'Rhythmical poetry'), ('Prose', 'Prose')], max_length=20),
        ),
    ]
