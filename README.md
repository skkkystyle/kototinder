# Kototinder — Tinder для котиков

Kototinder — это мобильное приложение на Flutter, которое позволяет "свайпать" котиков, как в настоящем Tinder!

Приложение использует [The Cat API](https://thecatapi.com) для получения изображений и информации о породах.

---

## Реализованные фичи

- Отображение случайного котика с названием породы
- Свайп влево (дизлайк) или вправо (лайк)
- Кнопки "Like" и "Skip" под карточкой
- Счётчик лайков в верхней части экрана
- Переход к детальному описанию породы по клику на карточку
- Экран списка всех пород с возможностью перехода к деталям
- Прогрузка нескольких котиков заранее — следующие карточки уже ждут под текущей
- Анимированный свайп: карточка плавно улетает за край экрана
- Анимация кнопок: изменение размера при нажатии
- Обработка сетевых ошибок с отображением понятных сообщений
- Современный UI с розово-фиолетовым градиентом и скруглёнными элементами
- Готово к сборке под Android (APK)
- Система авторизации (Sign in & Sign up)
- Онбординг с анимациями и перелистываниями
- Переход к Clean Arch
- Unit/Widget тесты

---

## Используемые пакеты

| Пакет | Назначение |
|------|-----------|
| `flutter` | Основной фреймворк |
| `http` | Запросы к The Cat API |
| `cached_network_image` | Кэширование и отображение изображений |
| `flutter_dotenv` | Загрузка API-ключа из `.env` |
| `flutter_launcher_icons` | Автоматическая генерация иконок приложения |

---

## Интерфейс и экраны

### Экран онбординга
- Основные советы по пользованию приложением

### Экраны авторизации
- Дефолтно

### Главный экран (`MainCatScreen`)
- Карточка кота с названием породы
- Свайпы и кнопки Like/Skip
- Анимация свайпа и изменения размера кнопок

### Экран деталей породы (`BreedDetailScreen`)
- Изображение кота
- Порода, описание, характер, происхождение, продолжительность жизни
- Фоновая подложка и рамка в стиле приложения

### Экран списка пород (`BreedsListScreen`)
- Список всех доступных пород
- Переход к деталям по тапу
- Информация о каждой породе в виде карточек

### Навигация
- Bottom Navigation Bar для переключения между:
    - Главным экраном
    - Списком пород

---

## Анимации и интерактивность

- **Анимированные свайпы**: при свайпе карточка плавно улетает влево или вправо с анимацией `SlideTransition`.
- **Прогрузка нескольких котиков**: в фоне всегда загружены 2–3 следующих кота, чтобы создать эффект бесконечного стека.
- **Анимация кнопок**: при нажатии кнопки "Like" и "Skip" плавно уменьшаются благодаря `AnimatedScale`.
- **Анимации кота на онбординге**
---

## Скриншоты интерфейса
[Главная страница](https://drive.google.com/file/d/19sVxhEPhIVVyEIpUCOUPBt20cpziqUXO/view?usp=sharing)

[Детали породы](https://drive.google.com/file/d/1rvP_qvYHqvxxyd0qY0jUDz29Z21_d2Bz/view?usp=sharing)  

[Список пород](https://drive.google.com/file/d/1tA5bHWcNQnhcdYfuPvrwDqMAZyjhTSTb/view?usp=sharing)  

[Онбординг 1](https://drive.google.com/file/d/1IkX8ZiSsAbT1lcc0VsptQVJNnesnA5RZ/view)

[Онбординг 2](https://drive.google.com/file/d/1m6yxGn-o3ekLJxEI_dpeZLdV5NK-7s9Y/view)

[Welcome](https://drive.google.com/file/d/1aS-YGh5JHtB9QyekIxzX7J0DLrDwF6Lc/view?usp=sharing)

[Sign in](https://drive.google.com/file/d/1UpxNlw6GCqrBIoZ13DhH3XshbTNcnGFL/view?usp=sharing)

[Sign up](https://drive.google.com/file/d/1A0jZVxsvHAA2nUy57L4LfXm-lnMOpf81/view?usp=sharing)

## Скринкаст анимации
[Видео](https://drive.google.com/file/d/1EE-7ZAd37ikPtnnLaCnxMbrkxryHajB6/view?usp=sharing)

---

## Скачать APK

> Последняя версия приложения доступна для скачивания ниже.

[Скачать Kototinder v1.0.0 (APK)](https://drive.google.com/file/d/1Lca9Jcqn6jh6SuTTbBnx4306sa5jr-eH/view?usp=sharing)
