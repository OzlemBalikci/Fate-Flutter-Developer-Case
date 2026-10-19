# Fate Flutter Developer Case — Çalışma dokümanı

Bu dosya case’in **yapılacaklar listesi ve uygulama kılavuzudur**. Orijinal PDF/Figma bu repoda yok; içerik `pubspec.yaml` stack’inden, mevcut koddan, Git geçmişinden ve bu tür bir teknik case’te değerlendirilen başlıklardan çıkarılmıştır.

Brief veya Figma eline geçince **bölüm 6** içindeki ekran tablosunu birebir güncelle. Stack ve mimari kısımlar (bölüm 3–5) brief’ten bağımsız olarak yapılmalıdır.

Son güncelleme: 2026-09-14.

---

## 1. Case neyi ölçüyor?

Değerlendirici şunlara bakacak:

| Başlık | Bu projede karşılığı |
| --- | --- |
| Mimari | `core/` + `features/<ad>/{data,domain,presentation}` |
| Durum yönetimi | `flutter_bloc` + `equatable` |
| DI | `get_it` + `injectable` |
| Navigasyon | `auto_route` |
| Modelleme | `freezed` + `json_serializable` |
| Ağ | `dio` (+ `dio_cookie_manager` ile oturum) |
| Firebase | Auth, Firestore, Analytics, Crashlytics |
| Yerel depolama | `hive` (cache) + `shared_preferences` |
| UI | Figma’ya sadık, `flutter_screenutil`, Roboto, light/dark theme |
| İçerik | `flutter_html` (HTML gövde) |
| Dil | `en` + `tr` (`AppLocalizations` / `context.l10n`) |
| Kalite | Hata katmanı, logger, test, temiz Git/PR |

Paket eklenmiş olması yetmez; **kullanıldığı** gösterilmelidir.

---

## 2. Mevcut durum

### Tamamlanan

- Flutter iskeleti, `main` / `develop` / `feature/*` Git akışı
- FlutterFire Android Gradle plugin’leri + `firebase.json` (`fate-developer-case`)
- `Firebase.initializeApp` (`lib/firebase_options.dart` gitignore’da; lokalde olmalı)
- GetIt + injectable: `SharedPreferences` (preResolve) ve `Dio`
- Light/dark `ThemeExtension`, renk/spacing/typography, Roboto fontları
- Exception / Failure eşlemesi
- `en` / `tr` l10n altyapısı (`appName`, `ok`, `cancel`, `retry`, `errorGeneric`)
- `ScreenUtilInit` (360×800) + `MaterialApp.router` kabuğu

### Bilerek commit edilmeyenler

`.gitignore`: `google-services.json`, `GoogleService-Info.plist`, `lib/firebase_options.dart`, `.env`. Bunları PR’a koyma. README’de “FlutterFire CLI ile yerelde üret” yaz.

### Eksik / kırık (feature’dan önce kapat)

- [ ] `MaterialApp.router` var, **`routerConfig` yok** — uygulama route olmadan ayağa kalkmaz
- [ ] `auto_route` paketi var, `AppRouter` yok
- [ ] `flutter_bloc` var, Bloc yok
- [ ] `hive` var, `Hive.initFlutter` yok; `hive_flutter` `pubspec`’te yok
- [ ] `logger` var, kullanılmıyor
- [ ] `firebase_auth` / `cloud_firestore` / `analytics` / `crashlytics` Dart’ta bağlı değil
- [ ] `flutter_html` kullanılmıyor
- [ ] `dio` interceptor / cookie / error mapper yok; `ApiConfig.baseUrl` boş
- [ ] `assets/images/` ve `assets/icons/` boş (`Assets` sınıfı boş generate)
- [ ] `test/widget_test.dart` hâlâ counter bekliyor
- [ ] `android/app/src/main/AndroidManifest.xml` içinde `INTERNET` yok (sadece debug/profile)
- [ ] `applicationId` hâlâ `com.example.fate_developer_case`
- [ ] `lib/features/` yok

---

## 3. Hedef klasör yapısı

Yeni kodu feature bazında yaz. `core`’a sadece paylaşılan altyapı koy.

```text
lib/
  main.dart
  app.dart
  firebase_options.dart          # gitignore
  di/
    di.dart
    di.config.dart               # generate
  l10n/
  router/
    app_router.dart
    app_router.gr.dart           # generate
  core/
    constants/
    theme/
    errors/
    network/                     # dio client, interceptor, api_config
    storage/                     # hive + prefs wrapper
    logging/
    firebase/                    # crashlytics / analytics helpers
  features/
    <feature>/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        bloc/
        pages/
        widgets/
```

Her feature için:

1. Entity (domain) → Model (data, `freezed` / `json_serializable`)
2. Repository interface (domain) + impl (data)
3. Use case (tek iş)
4. Bloc/Cubit (presentation)
5. Page + widget
6. `@injectable` + `build_runner`
7. Route (`@RoutePage`)
8. String’ler ARB’de (`en` + `tr`)

---

## 4. Faz 0 — Core’u bitir

Feature yazmadan bu faz kapansın. Branch: `feature/core-runtime` (veya benzeri), base: `develop`.

### 4.1 AutoRoute

- `lib/router/app_router.dart` içinde `@AutoRouterConfig`
- İlk rotalar: splash (veya home placeholder) yeterli
- `app.dart`: `routerConfig: getIt<AppRouter>().config()`
- `AppRouter`’ı GetIt’e `@lazySingleton` kaydet
- `dart run build_runner build`

### 4.2 Android / iOS çalışma garantisi

- Main `AndroidManifest.xml` → `INTERNET`
- Firebase Auth kullanacaksan `minSdk >= 23`
- `applicationId`’yi example’dan çıkar (Firebase’deki Android app ile aynı olsun)
- iOS: `GoogleService-Info.plist` lokalde olsun (commit etme)
- Release’te de ağ için permission’ın main manifest’te olduğunu doğrula

### 4.3 Hive

- `hive_flutter` ekle
- `main.dart`: `await Hive.initFlutter()` (`configureDependencies` öncesi veya DI module `@preResolve`)
- Box açmayı feature datasource’a bırak; `core/storage` sadece init + helper

### 4.4 Logger

- `core/logging` içinde tek `Logger` instance
- GetIt’e `@lazySingleton`
- `print` kullanma

### 4.5 Test dumanı

- Counter testini sil
- `FateDeveloperCaseApp` + `AppRouter` ile “uygulama ayağa kalkıyor” widget testi
- Firebase/Hive’ı testte mock’la veya `main.dart`’ı testten ayır (app widget’ı DI’siz pump edilebilsin)

### 4.6 Codegen alışkanlığı

Değişen her `injectable` / `auto_route` / `freezed` / `json_serializable` sonrası:

```powershell
dart run build_runner build --delete-conflicting-outputs
```

Yeni l10n key sonrası:

```powershell
flutter gen-l10n
```

---

## 5. Faz 1 — Cross-cutting altyapı

Branch önerisi: `feature/network-firebase`.

### 5.1 Dio client

`lib/core/network/` altında:

- [ ] `ApiConfig.baseUrl` — brief’teki REST kökü; yoksa Firestore-only ise bile placeholder’ı belgele
- [ ] Timeout’lar (şu an 30s, duruma göre kısalt)
- [ ] `LoggerInterceptor` (request/response/error)
- [ ] `ErrorInterceptor` → `AppException` (`statusCode` 401, 403, 404, 422, timeout, socket)
- [ ] `dio_cookie_manager` + `CookieJar` (persist: `hive` veya `shared_preferences` değil, `cookie_jar` / `dio_cookie_manager` dokümantasyonundaki kalıcı jar)
- [ ] 401’de session temizle + login’e yönlendir (router guard ile)

`RegisterModule.dio()` şişmesin; interceptor’ları ayrı sınıfta bağla.

### 5.2 Firebase Auth

- [ ] Console’da Email/Password (brief başka method diyorsa onu) açık
- [ ] `AuthRepository` (domain) + Firebase impl (data)
- [ ] Login / register / logout / `authStateChanges` stream
- [ ] Hataları `AuthFailure`’a maple (yanlış şifre, e-posta alınmış, network)
- [ ] AutoRoute **auth guard**: oturum yoksa auth, varsa ana kabuk

### 5.3 Firestore

- [ ] Koleksiyon şemasını brief’ten yaz (`docs/firebase-schema.md` açılabilir)
- [ ] Rules: geliştirme için bile “herkese açık yazma” bırakma; en azından authenticated read
- [ ] Model’leri `freezed` + `fromJson`/`toJson` (Firestore `Map` için factory)
- [ ] Offline/cache ihtiyacı varsa Hive ile repository’de birleştir (remote first, cache fallback)

### 5.4 Analytics

- [ ] `FirebaseAnalytics` GetIt’de
- [ ] `AutoRouteObserver` veya `NavigatorObserver` ile ekran adı logla
- [ ] En az şu event’ler: `login`, `sign_up`, `logout`, liste item tıklama, hata gösterimi
- [ ] Debug’da `Analytics` DebugView ile bir event gör

### 5.5 Crashlytics

Android plugin ekli; Dart tarafı yok.

`main.dart` içinde, `runApp` öncesi:

- `FlutterError.onError` → `recordFlutterFatalError`
- `PlatformDispatcher.instance.onError` → `recordError`
- Zone / `runZonedGuarded` (isteğe bağlı ama case için artı)
- İlk deneme: bilinçli bir test crash’i, sonra kaldır

### 5.6 `flutter_html`

Brief’te HTML içerik (gizlilik, makale, fal/yorum metni vb.) varsa tek widget’ta sarmala (`core` veya ilgili feature). Theme renkleriyle uyumlu `style` ver. Ham HTML’i `Text` ile basma.

---

## 6. Faz 2 — Feature’lar

Orijinal ekran listesi repoda olmadığı için burada **stack’in zorunlu kıldığı yetenekler** var. Brief gelince tabloyu kilitle.

### 6.1 Brief şablonu (Figma/PDF’den doldur)

| # | Ekran | Route | Kaynak (API / Firestore / local) | Bloc | Durum |
| --- | --- | --- | --- | --- | --- |
| 1 |  |  |  |  |  |
| 2 |  |  |  |  |  |
| 3 |  |  |  |  |  |

Figma asset’lerini `assets/images/` ve `assets/icons/` altına koy, `flutter pub get` (flutter_gen) çalıştır, `Assets` üzerinden referans ver. Hardcoded network URL (Figma export linki) kullanma.

### 6.2 Bu stack ile neredeyse kesin beklenen akışlar

Bunlar uydurma ürün hikâyesi değil; paket seçiminin gerektirdiği gösterimler:

1. **Açılış / session**  
   Splash veya guard: prefs/Hive + `FirebaseAuth.currentUser` (veya cookie). İlk açılış vs kayıtlı oturum.

2. **Kimlik**  
   En az bir gerçek auth akışı (form validasyonu, loading, hata snackbar/`errorGeneric`, başarıda yönlendirme).

3. **Liste**  
   Remote’dan liste (Firestore query veya Dio GET). Loading / empty / error / content. Mümkünse pull-to-refresh. Uzun listeyse pagination.

4. **Detay**  
   Liste item → detay. HTML varsa `flutter_html`.

5. **Yazma işlemi**  
   En az bir create/update/delete (yorum, favori, profil alanı, vs. — brief ne diyorsa). Başarı ve hata geri bildirimi.

6. **Profil veya ayarlar**  
   Kullanıcı bilgisi, çıkış, dil (`tr`/`en`) göstergesi. Dil değişince ARB string’leri değişsin.

7. **Responsive / theme**  
   `ScreenUtil`, mevcut `LightAppTheme` / `DarkAppTheme`. Sistem `themeMode` veya in-app toggle (brief’de varsa). Küçük telefon (360) ve tablet/büyük ekranda taşma olmasın.

Her ekranda:

- Hardcoded TR/EN string yok → ARB
- `context.colors` / typography / spacing
- Bloc state: `initial/loading/success/failure` (veya sealed `freezed` state)
- Failure → kullanıcı mesajı (`errorGeneric` veya spesifik key)

### 6.3 Feature implementasyon sırası

1. Domain entity + repository interface  
2. Data source (Firebase veya Dio) + model  
3. Repository impl + injectable  
4. Use case  
5. Bloc + page (önce dummy UI, sonra Figma)  
6. Route + guard  
7. Analytics event  
8. Widget veya unit test (en az kritik path)

---

## 7. Faz 3 — Kalite ve teslim

- [ ] Kullanıcıya dönük tüm metinler `app_en.arb` + `app_tr.arb`
- [ ] `flutter analyze` temiz
- [ ] En az 1 unit test (repository veya use case / Failure mapping)
- [ ] En az 1 widget test (ekran veya paylaşılan widget)
- [ ] Error / empty / loading görselleri
- [ ] README: nasıl çalıştırılır, FlutterFire nasıl üretilir, mimari özeti
- [ ] PR’larda secret yok
- [ ] `test/widget_test.dart` counter kalıntısı yok

---

## 8. Git akışı (bu repoda kullanılan)

```text
main          ← teslim / stabil
develop       ← entegrasyon
feature/*     ← tek konu
```

Kurallar:

- `develop` üzerine doğrudan commit yok
- Feature bitince PR **base = `develop`**
- Case tamamen bitince `develop` → `main` ayrı PR
- Commit mesajı: `feat: Add ...` / `fix: ...` / `chore: ...`
- Firebase config, font, theme, DI, l10n gibi işler **ayrı commit**; “her şeyi tek commit” yok

Örnek feature branch’ler:

| Branch | İş |
| --- | --- |
| `feature/core-runtime` | router, hive, logger, manifest, test dumanı |
| `feature/network-firebase` | dio interceptors, crashlytics, analytics |
| `feature/auth` | login/register/guard |
| `feature/<ekran>` | brief’teki her ana ekran |

---

## 9. Uygulama sırası (özet)

1. Faz 0 — router + hive + logger + permission + kırık test  
2. Faz 1 — Dio/error + Crashlytics/Analytics  
3. Brief/Figma’yı bölüm 6 tablosuna işle  
4. Auth + guard  
5. Liste → detay → yazma → profil  
6. l10n + Figma pixel-check  
7. Test + README + `develop` → `main`

---

## 10. Komutlar

```powershell
flutter pub get
flutter gen-l10n
dart run build_runner build
flutter analyze
flutter test
flutter run
```

Firebase (lokal, bir kez):

```powershell
dart pub global activate flutterfire_cli
flutterfire configure --project=fate-developer-case
```

Üretilen `lib/firebase_options.dart` ve `android/app/google-services.json` commit edilmez.

---

## 11. Brief geldiğinde yapılacak tek iş

PDF/Figma’yı `docs/brief/` altına koy (binaries büyükse link yeter) ve bu dosyada şunları güncelle:

1. Bölüm 6.1 ekran tablosu  
2. Auth yöntemi (Firebase e-posta mı, REST cookie mi, ikisi mi)  
3. `ApiConfig.baseUrl` ve Firestore koleksiyon adları  
4. Zorunlu vs bonus maddeler  

O zamana kadar **Faz 0 ve Faz 1’i bitirmek** doğru sıradır; ürün ekranını tahmin ederek yazma.
