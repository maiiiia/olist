Olist E-commerce: продуктовая аналитика и A/B-тестирование

Учебный проект. Загрузка данных в Postgres, подсчет продуктовых метрик с помощью SQL, A/B тестирование. 
Использованы данные Olist e-commerce dataset (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) - данные о интернет магазине Olist.

1. Подготовка базы

Создана база данных olist_db и таблицы customers, orders, order_items, sellers, products, order_reviews, order_payments в PostgreSQL.

ER-диаграмма:
![Иллюстрация к проекту](https://github.com/maiiiia/olist/blob/main/sql/olist_db%20-%20public.png)

2. Продуктовые метрики

Подсчитаны основные метрики.

Скрипты находятся в sql/.

3. A/B-тестирование 

Контекст:
Март 2018 г. Команда Olist запустила новый алгоритм рекомендаций товаров.
Нужно оценить, стоит ли внедрять фичу.

Методология:

Целевая метрика — ARPU (Average Revenue Per User)

Группы A/B формируются случайно (по customer_id)

Проверка SRM (хи-квадрат тест)

A/A-тест — контроль корректности

Расчет MDE

A/B-тест — t-test и Манна–Уитни

Наблюдаемое измененеи ARPU примерно +10 %, p < 0.01

95 % доверительный интервал: (4.46 ; 22.95)

Вывод: можно раскатывать фичу

Скрипты находятся в notebooks/.










