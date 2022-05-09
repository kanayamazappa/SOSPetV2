# Generated by Django 3.2.9 on 2021-11-10 13:25

from django.db import migrations
import imagekit.models.fields


class Migration(migrations.Migration):

    dependencies = [
        ('banner', '0002_alter_banner_banner'),
    ]

    operations = [
        migrations.AlterField(
            model_name='banner',
            name='banner',
            field=imagekit.models.fields.ProcessedImageField(help_text='Imagem do banner da home', upload_to='banners', verbose_name='Banner'),
        ),
    ]
