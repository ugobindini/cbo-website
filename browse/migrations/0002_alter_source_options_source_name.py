# Generated by Django 5.0.4 on 2024-07-24 11:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('browse', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='source',
            options={'ordering': ['bib_id']},
        ),
        migrations.AddField(
            model_name='source',
            name='name',
            field=models.CharField(default='', help_text='The source location.', max_length=200),
            preserve_default=False,
        ),
    ]
