# Generated by Django 5.1.6 on 2025-04-17 11:24

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0003_order_watch'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='Watch',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='orders_by_Watch', to='app.watch'),
        ),
    ]
