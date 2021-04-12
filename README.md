![api_yamdb](https://github.com/Morales1991/yamdb_final/actions/workflows/yamdb_workflow.yaml/badge.svg)


# api_yamdb

Проект YaMDb пользовательский портал, на котором пользователи обсуждают: «Книги», «Фильмы», «Музыку».

## Регистрация
            
  Регистрация пользователя осуществляется по username и email, после регистрации на указанный емаил приходит код подтвержения.
  
  Аутентификация осуществляется по JWT-токену, для получения JWT токена необходимо предоставить email, и код подтверждения из почты.

## Пользовательские роли
            
Аноним — может просматривать описания произведений, читать отзывы и комментарии.

Аутентифицированный пользователь (user)— может читать всё, дополнительно может публиковать отзывы и ставить рейтинг произведениям (фильмам/книгам/песенкам), может комментировать чужие отзывы и ставить им оценки; может редактировать и удалять свои отзывы и комментарии.

Модератор (moderator) — те же права, что и у Аутентифицированного пользователя плюс право удалять любые отзывы и комментарии.

Администратор (admin) — полные права на управление проектом и всем его содержимым. Может создавать и удалять произведения, категории и жанры. Может назначать роли пользователям.

Администратор Django — те же права, что и у роли Администратор.

## Алгоритм регистрации пользователей
Пользователь отправляет POST-запрос с параметром username и email на /api/v1/auth/email/.

YaMDB отправляет письмо с кодом подтверждения (confirmation_code) на адрес email .

Пользователь отправляет POST-запрос с параметрами email и confirmation_code на /api/v1/auth/token/, в ответе на запрос ему приходит token (JWT-токен).

Эти операции выполняются один раз, при регистрации пользователя. В результате пользователь получает токен и может работать с API, отправляя этот токен с каждым запросом.

После регистрации и получения токена пользователь может отправить PATCH-запрос на /api/v1/users/me/ и заполнить поля в своём профайле (описание полей — в /redoc).

Если пользователя создаёт администратор (например, через POST-запрос api/v1/users/...) — письмо с кодом отправлять не нужно.


## Ресурсы API YaMDb
              
Ресурс AUTH: аутентификация.

Ресурс USERS: пользователи.

Ресурс TITLES: произведения, к которым пишут отзывы (определённый фильм, книга или песенка).

Ресурс CATEGORIES: категории (типы) произведений («Фильмы», «Книги», «Музыка»).

Ресурс GENRES: жанры произведений. Одно произведение может быть привязано к нескольким жанрам.

Ресурс REVIEWS: отзывы на произведения. Отзыв привязан к определённому произведению.

Ресурс COMMENTS: комментарии к отзывам. Комментарий привязан к определённому отзыву.


## Развертывание проекта

Развертывание проекта осуществляется командой docker-compose up

Для старта необходимы переменные окружения в фаиле .env

Миграции, сбор статики происходит автоматически.

Для создания суперпользователя необходимо зайти в контейне docker exec -it id_container bash

Выполнить python manage.py createsuperuser
