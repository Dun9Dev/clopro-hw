# Домашнее задание: Организация сети в Yandex Cloud - Выполнил Shestovskikh Daniil

## Описание проекта

В рамках домашнего задания создана инфраструктура в Yandex Cloud с использованием Terraform:

- VPC сеть
- Публичная подсеть (public) с сетью `192.168.10.0/24`
- Приватная подсеть (private) с сетью `192.168.20.0/24`
- NAT-инстанс с IP `192.168.10.254` (образ `fd80mrhj8fl2oe87o4e1`)
- Публичная виртуальная машина с выходом в интернет
- Приватная виртуальная машина без публичного IP, с маршрутом всего трафика через NAT-инстанс

## Требования

- Terraform >= 1.0
- Yandex Cloud аккаунт
- SSH ключ (ed25519)

## Развертывание

### 1. Клонирование репозитория

```bash
git clone https://github.com/Dun9Dev/clopro-hw.git
cd clopro-hw
```

### 2. Настройка переменных

Создайте файл `terraform.tfvars`:

```hcl
yc_token     = "ваш_oauth_токен"
yc_cloud_id  = "ваш_cloud_id"
yc_folder_id = "ваш_folder_id"
zone         = "ru-central1-a"
```

### 3. Инициализация и применение

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### 4. Результаты

После успешного применения будут выведены:

| Вывод | Описание |
|-------|----------|
| `nat_public_ip` | Публичный IP NAT-инстанса |
| `public_vm_ip` | Публичный IP виртуальной машины |
| `private_vm_ip` | Внутренний IP приватной ВМ |
| `ssh_to_public` | Команда для подключения к публичной ВМ |
| `ssh_to_private_via_public` | Команда для подключения к приватной ВМ через публичную |

## Проверка работы

### Подключение к публичной ВМ и проверка интернета

```bash
ssh -i ~/.ssh/id_ed25519 ubuntu@<public_vm_ip>
ping 8.8.8.8
curl ifconfig.me
```

### Подключение к приватной ВМ через публичную

```bash
ssh -i ~/.ssh/id_ed25519 -J ubuntu@<public_vm_ip> ubuntu@<private_vm_ip>
ping 8.8.8.8
curl ifconfig.me
```

Ожидаемый результат: `curl ifconfig.me` на приватной ВМ должен показать IP NAT-инстанса.

## Скриншоты

### Terraform output

![terraform output](https://github.com/Dun9Dev/clopro-hw/blob/main/img/Screenshot_8.png)

### Публичная ВМ: ping 8.8.8.8
### Публичная ВМ: curl ifconfig.me

![public-vm-curl](https://github.com/Dun9Dev/clopro-hw/blob/main/img/Screenshot_1.png)

### Приватная ВМ: ping 8.8.8.8 (через jump host)
### Приватная ВМ: curl ifconfig.me (выход через NAT)

![private-vm-curl](https://github.com/Dun9Dev/clopro-hw/blob/main/img/Screenshot_2.png)

## Очистка ресурсов

Вот исправленный список с ссылками на файлы:

## Структура файлов

| Файл | Назначение |
|------|------------|
| [`provider.tf`](https://github.com/Dun9Dev/clopro-hw/blob/main/provider.tf) | Настройка провайдера Yandex Cloud |
| [`variables.tf`](https://github.com/Dun9Dev/clopro-hw/blob/main/variables.tf) | Переменные (токен, cloud_id, folder_id, зона) |
| [`network.tf`](https://github.com/Dun9Dev/clopro-hw/blob/main/network.tf) | VPC, подсети, таблица маршрутизации |
| [`instances.tf`](https://github.com/Dun9Dev/clopro-hw/blob/main/instances.tf) | NAT-инстанс, публичная и приватная ВМ |
| [`outputs.tf`](https://github.com/Dun9Dev/clopro-hw/blob/main/outputs.tf) | Выходные переменные (IP адреса, команды SSH) |


