
# 🏦 Mini-Lakehouse — Banking Anti-Fraud Platform
> **ℹ️ Документация базовой (учебной) версии:**  
> [📖 Перейти к базовой версии README](./oldREADME.md)

[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Trino](https://img.shields.io/badge/Trino-DD00A1?logo=trino&logoColor=white)](https://trino.io/)
[![Apache Iceberg](https://img.shields.io/badge/Apache_Iceberg-00B4EB?logo=apache&logoColor=white)](https://iceberg.apache.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org/)

**Mini-Lakehouse** — это аналитическая платформа банковского уровня, предназначенная для выявления мошеннических транзакций (**Anti-Fraud**) и построения единого профиля клиента (**Customer 360**). 

Проект реализует концепцию **Lakehouse**, объединяя горячие оперативные данные и огромные исторические архивы в единый аналитический контур.

---

## 🎯 Бизнес-сценарий
Банковская система требует моментальной реакции на подозрительные действия. Наш проект решает задачу связки «горячих» справочников клиентов из СУБД с «холодными» архивами транзакций. 
*   **Антифрод:** Выявление транзакций от клиентов с высоким уровнем риска, превышающих лимиты.
*   **Аудит:** Обеспечение возможности отката к историческим срезам данных (Time Travel) по требованиям регулятора.

---

## 🏗️ Архитектура слоев (Medallion Architecture)

Данные проходят через три логических уровня для обеспечения чистоты и производительности:

| Слой | Описание | Технология |
| :--- | :--- | :--- |
| **Bronze** | Сырые данные (RAW) | MinIO (S3) |
| **Silver** | Очищенные, партиционированные данные | Iceberg (Parquet) |
| **Gold** | Бизнес-витрины (Anti-Fraud Report) | Trino (Federated View) |

---

## 🛠️ Стек технологий

*   **SQL-движок:** Trino (выполнение федеративных JOIN-запросов между Postgres и S3).
*   **Хранение:** MinIO (объектное хранилище) + Apache Iceberg (транзакционный табличный формат).
*   **Справочники:** PostgreSQL (профили клиентов, лимиты, уровни риска).

---

## 🚀 Запуск и проверка

### 1. Подготовка инфраструктуры
```bash
git clone [https://github.com/oayaivaivb/mini-lakehouse.git](https://github.com/oayaivaivb/mini-lakehouse.git)
cd mini-lakehouse
docker compose up -d

```

### 2. Инициализация (Banking Domain)

Выполнение скриптов, разворачивающих структуру медальонной архитектуры и заливку фрод-паттернов:

```bash
# Создание схем, таблиц и загрузка тестовых данных
cat sql/01_create_schema.sql | docker compose exec -T trino trino
cat sql/02_create_tables.sql | docker compose exec -T trino trino
cat sql/03_insert_data.sql | docker compose exec -T trino trino

```

### 3. Интеграционное тестирование платформы

#### A. Сценарий «Антифрод» (Кросс-системный анализ)
Проверка работы Gold-витрины. Запрос выполняет федеративный JOIN, сопоставляя холодный лог транзакций и горячий справочник СУБД. Фильтр настроен на выявление аномалий: переводы от клиентов из группы риска (`HIGH`), объем которых превышает 80% от доступного лимита.

```bash
cat sql/04_select_join.sql | docker compose exec -T trino trino

```

*(Ожидаемый результат: система успешно изолирует серию подозрительных переводов клиента "Анна Смирнова").*

#### B. Сценарий «Аудит» (Механика Time Travel)

Тестирование ACID-свойств формата Iceberg и возможности отката к историческим срезам данных (требование регуляторов):

1. **Имитация инцидента:** Принудительное обнуление суммы транзакции оператором (команда `UPDATE`).
2. **Аудит прошлого состояния:** Чтение оригинальной суммы из предыдущего снапшота с помощью конструкции `FOR VERSION AS OF <snapshot_id>`, игнорируя текущие изменения.

---

## 🔗 Доступ к интерфейсам

* **Trino UI:** [http://localhost:8080](http://localhost:8080)
* **MinIO Console:** [http://localhost:9001](http://localhost:9001)
---

## 📁 Структура проекта

```text
mini-lakehouse/
├── docs/                                 # Документация проекта
├── healthcheck/
│   ├── check_services.sh                 # Баш-скрипт проверки портов и БД
│   └── check_trino.sql                   # SQL-проверка для Trino
├── postgres/
│   └── init/
│       └── 01_init_service_db.sql        # Скрипт инициализации системных таблиц Iceberg
├── sql/                                  # SQL скрипты  
├── trino/
│   └── catalog/
│       ├── iceberg.properties            # Конфиг подключения Iceberg -> MinIO/PG
│       └── postgresql.properties         # Конфиг подключения Trino -> PG (сервисная БД)
├── docker-compose.yml                    # Манифест инфраструктуры
├── README.md                             # Описание проекта
└── oldREADME.md                          # Описание базовой версии
```