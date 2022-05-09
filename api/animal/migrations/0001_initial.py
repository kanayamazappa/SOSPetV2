# Generated by Django 3.2.9 on 2021-11-03 18:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('login', '__first__'),
    ]

    operations = [
        migrations.CreateModel(
            name='Breed',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='Raça do animal de estimação', max_length=150, verbose_name='Raça')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'Raça',
                'verbose_name_plural': 'Raças',
            },
        ),
        migrations.CreateModel(
            name='Coat',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='Pelagem do animal de estimação', max_length=150, verbose_name='Pelagem')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'Pelagem',
                'verbose_name_plural': 'Pelagens',
            },
        ),
        migrations.CreateModel(
            name='Color',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='Cor do animal de estimação', max_length=150, verbose_name='Cor')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'Cor',
                'verbose_name_plural': 'Cores',
            },
        ),
        migrations.CreateModel(
            name='Specie',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='Espécie do animal de estimação', max_length=150, verbose_name='Espécie')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
            options={
                'verbose_name': 'Espécie',
                'verbose_name_plural': 'Espécies',
            },
        ),
        migrations.CreateModel(
            name='Pet',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='Nome do animal de estimação', max_length=150, verbose_name='Nome')),
                ('genre', models.CharField(choices=[('M', 'Masculino'), ('F', 'Feminino')], max_length=1, verbose_name='Sexo')),
                ('microship', models.CharField(blank=True, help_text='Microchip do animal de estimação', max_length=150, verbose_name='Microchip')),
                ('age', models.PositiveSmallIntegerField(help_text='Idade do animal de estimação', verbose_name='Idade')),
                ('castrated', models.BooleanField(default=False, help_text='Animal de estimação é castrado?', verbose_name='Castrado')),
                ('weight', models.PositiveSmallIntegerField(blank=True, help_text='Peso do animal de estimação', verbose_name='Peso')),
                ('height', models.PositiveSmallIntegerField(blank=True, help_text='Altura do animal de estimação (cm)', verbose_name='Altura')),
                ('personality', models.CharField(blank=True, help_text='Personalidade do animal de estimação', max_length=150, verbose_name='Personalidade')),
                ('vaccination', models.CharField(blank=True, help_text='Vacinação do animal de estimação', max_length=150, verbose_name='Vacinação')),
                ('available', models.BooleanField(default=1, help_text='Animal de estimação disponível para adoção?', verbose_name='Disponível')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('breed', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='animal.breed')),
                ('coat', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='animal.coat')),
                ('color', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='animal.color')),
                ('login', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='login.login')),
                ('specie', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='animal.specie')),
            ],
            options={
                'verbose_name': 'Animal',
                'verbose_name_plural': 'Animais',
            },
        ),
        migrations.AddField(
            model_name='breed',
            name='specie',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='animal.specie'),
        ),
    ]
