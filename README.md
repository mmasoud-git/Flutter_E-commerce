# Flutter Demo E-commerce (Assignment Scaffold)

This is a clean scaffold that fulfills the required features:

- Login page with auto-login
- Main page (products list) with **local** search (no extra API calls)
- Favorites with **local storage** (SharedPreferences)
- Cart screen that fetches all cart data via API and **filters on the client** by current userId
- Profile screen showing logged-in user data
- Info icon that plays a **YouTube video inside the app** (not external)

> ⚠️ Set your API `BASE_URL` and endpoints in `lib/utils/constants.dart` and `lib/services/*` according to your Postman collection.
> Add authorization header in `ApiService` (comment in file) if needed.

## Run locally

```bash
# create a new flutter app (if you want full android/ios folders)
flutter create flutter_demo_ecommerce
cd flutter_demo_ecommerce

# replace lib/ and pubspec.yaml with the ones from this zip
# then:
flutter pub get
flutter run
```

Alternatively, unzip these files into a new `flutter create` project.

## Endpoints to adapt

- `POST /auth/login` -> returns `{ token, user: { id, name, email } }`
- `GET /products` -> returns `[ { id, title, description, price, image } ]`
- `GET /cart` -> returns carts for multiple users; the app filters by `userId`

If your JSON differs, adjust the `fromJson` methods in models.

## Security & Performance

- Token stored in SharedPreferences.
- You can enable an Authorization header in `ApiService` via an interceptor.
- ListView.builder + local filtering for performance.
- Minimal rebuilds via Provider.

## GitHub Submission

1. Create a **private** repo.
2. Push code.
3. Invite **mohammadLubbad2k**.
4. Include your Postman collection and mention the endpoints you used.

Good luck! ✨