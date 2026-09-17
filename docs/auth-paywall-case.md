# Auth & Paywall Case — Görev Listesi

Flutter + Firebase + Adapty varsayımıyla hazırlanmıştır. Farklı bir stack kullanılıyorsa buna göre uyarlanmalıdır.

## 1. Proje Kurulumu & Bağımlılıklar

- `firebase_core`, `cloud_firestore`, `firebase_auth` paketlerini ekle
- `adapty_flutter` paketini ekle
- State management seç (Riverpod / Bloc / Provider)
- `SharedPreferences` veya benzeri: "kullanıcı daha önce onboarding gördü mü" bilgisini local'de tutmak için

## 2. Launch / Auth Akışı

- **SplashScreen / AuthGate** widget'ı oluştur — uygulama açılışında ilk render edilen yer burası
- Kontrol sırası:
  1. `FirebaseAuth.instance.currentUser` dolu mu? → doluysa direkt **HomePage**'e git
  2. Boşsa → local'de "onboarding görüldü" flag'i var mı kontrol et
     - Yoksa → **Onboarding** (2-3 sayfa, PageView) göster
- Onboarding'de "Start" butonuna basınca:
  - `FirebaseAuth.instance.signInAnonymously()` çağır
  - Local flag'i `true` yap (bir daha onboarding görünmesin)
  - Başarılıysa **HomePage**'e yönlendir
  - Hata durumunu da handle et (network yoksa vs. — kullanıcıya mesaj göster)
- **Not:** Mevcut kullanıcı (existing user) anonim login sonrası tekrar açtığında zaten `currentUser` dolu olacağı için onboarding'i otomatik atlayacak — ayrıca bir "existing user" flag'ine gerek kalmayabilir, sadece `currentUser` kontrolü yeterli.

## 3. Firestore Veri Modeli

- `users/{uid}` koleksiyonu/dokümanı oluştur
- Alan: `isPro: bool` (default `false`)
- Kullanıcı ilk oluştuğunda (anonim login sonrası) bu dokümanı oluştur:
  - `FirebaseAuth` `authStateChanges()` dinleyip, kullanıcı ilk kez oluşturulduğunda Firestore'da doc yoksa `isPro: false` ile oluştur

## 4. Real-Time isPro Dinleme

- `users/{uid}` dokümanı için `snapshots()` (Stream) kullan, `get()` değil
- Bunu bir global state'e bağla (örn. `StreamProvider<bool>`) çünkü hem AppBar hem Home hem Paywall bu değere reaktif olacak
- Stream'i uygulama genelinde tek bir yerden expose et (tekrar tekrar dinleme oluşturma)

## 5. Home Page

- **AppBar:**
  - `isPro == true` ise "Pro" badge/ikon **gösterme**
  - `isPro == false` ise "Pro" badge/ikon **göster** (isteğe bağlı: tıklanınca paywall açılabilir)
- **"AI Magic" (Image Generation) butonu/kartı:**
  - `isPro == true` → normal tıklanabilir, feature'a git
  - `isPro == false` → tıklanınca (launch'ta değil, tıklamada) Paywall'ı modal/bottom sheet olarak aç, feature'a gitme

## 6. Paywall Ekranı

- **Adapty SDK boilerplate:**
  - `Adapty.activate()` app başlangıcında (`main.dart`)
  - Paywall configürasyonunu Adapty'den çekmeye çalış (gerçek store bağlantısı olmadığı için burada mock/hardcoded UI da kullanılabilir)
- **"Buy" butonuna basınca:**
  1. Loading state'e geç (buton disable + spinner)
  2. `Future.delayed(Duration(seconds: 2))` ile satın alma simülasyonu
  3. Süre bitince Firestore'da `users/{uid}` dokümanındaki `isPro` alanını `update({'isPro': true})` ile güncelle
  4. Hata durumu için try/catch ekle (Firestore yazma hatası vs.)
- Paywall'ı **manuel kapatma** — Stream zaten `isPro=true` olduğunda otomatik kapatacak (bkz. madde 7), ama kullanıcı loading sırasında da bekleyecek şekilde UI'ı kilitli tut

## 7. Real-Time UI Güncelleme (Reaktif Kapanma)

- Paywall widget'ı, `isPro` stream'ini dinlesin (`ref.listen` / `BlocListener` / `StreamBuilder` — hangi state yönetimi kullanıyorsan onun "listen" mekanizması)
- `isPro` değeri `false`'tan `true`'ya geçtiği anda:
  - `Navigator.pop(context)` ile Paywall'ı otomatik kapat
- HomePage AppBar ve "AI Magic" butonu zaten Stream'e bağlı olduğu için (madde 4-5) otomatik olarak yeniden render olacak — ekstra bir "refresh" tetiklemene gerek yok, bu Stream mimarisinin doğal sonucu

## 8. Test Edilmesi Gereken Senaryolar

- [ ] İlk kurulum: onboarding görünüyor mu, "Start" anonim login yapıyor mu
- [ ] Uygulamayı kapatıp açma: onboarding tekrar çıkmıyor mu (existing user akışı)
- [ ] Non-pro kullanıcı AI Magic'e tıklayınca paywall açılıyor mu
- [ ] Buy'a basınca 2 saniyelik loading + Firestore update çalışıyor mu
- [ ] Firestore'da `isPro` manuel olarak console'dan `true` yapılırsa (satın alma simülasyonu dışında), paywall açıksa otomatik kapanıyor mu — Stream'in gerçekten çalıştığının kanıtı
- [ ] Uygulamayı yeniden başlatınca (pro olduktan sonra) AppBar'da Pro badge kalıcı olarak kayboluyor mu

## 9. Ekstra / Nice-to-have

- Anonim kullanıcıyı ileride email/Google ile "account linking" yapma ihtimaline karşı `linkWithCredential` kullanılabilir (case'de istenmiyor ama mimariyi bozmaz)
- **Firestore güvenlik kuralları:** Kullanıcı sadece kendi `isPro` alanını okuyabilsin, **yazamasın** — gerçek hayatta bu yazma işlemini backend/Cloud Function yapmalı. Bu case'de client'tan yazıyoruz çünkü simülasyon; bunu README'de not olarak belirtmek işi profesyonelleştirir.
