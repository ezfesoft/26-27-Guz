// ignore_for_file: lines_longer_than_80_chars
import '../domain/models/activity_models.dart';

/// Görsel Programlama (C# Windows Forms) — 14 Hafta × 5 Soru = 70 Soru
/// Kalıp Kodu Rehberi:
///   K1=Tanımlama, K2=Karşılaştırma, K3=KodÇıktısı, K4=HataBul,
///   K5=Senaryo, K6=SıralamaSec, K7=HangiDurumda, K8=BoslukDoldur
const Map<String, ActivityModel> gpActivities = {
  // ══════════════════════════════════════════
  // HAFTA 1 — Görsel Programlamaya Giriş
  // ══════════════════════════════════════════
  'gp-w01-a01': ActivityModel(
    id: 'gp-w01-a01',
    type: ActivityType.choice,
    title: 'IDE Nedir? (K1)',
    skill: 'concept_recognition',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'IDE (Integrated Development Environment) kavramı aşağıdakilerden hangisini ifade eder?',
      options: [
        ActivityOption(id: 'a', text: 'Yalnızca metin yazma işlevi gören bir uygulama'),
        ActivityOption(id: 'b', text: 'Kod yazma, derleme, hata ayıklama ve çalıştırma araçlarını tek çatıda sunan geliştirme ortamı'),
        ActivityOption(id: 'c', text: 'Ağ paketlerini izleyen güvenlik yazılımı'),
        ActivityOption(id: 'd', text: 'Veritabanı yönetim sistemi'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'IDE; kod editörü, derleyici, hata ayıklayıcı (debugger) ve çalıştırma araçlarını tek bir pencerede bir araya getirir. Visual Studio bu kategorinin en kapsamlı örneklerinden biridir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w01-a02': ActivityModel(
    id: 'gp-w01-a02',
    type: ActivityType.choice,
    title: 'Visual Studio Panelleri (K6)',
    skill: 'tool_knowledge',
    cognitiveLevel: 'understand',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Visual Studio\'da "Toolbox" panelinin temel işlevi aşağıdakilerden hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'Projedeki dosya ve klasör yapısını göstermek'),
        ActivityOption(id: 'b', text: 'Çalışma zamanı hatalarını listelemek'),
        ActivityOption(id: 'c', text: 'Forma sürükle-bırak ile eklenebilecek kontrolleri (Button, Label vb.) listelemek'),
        ActivityOption(id: 'd', text: 'Seçili kontrolün özelliklerini (Properties) göstermek'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'Toolbox paneli, Windows Forms uygulamalarında kullanılabilecek tüm görsel kontrolleri kategoriler halinde listeler. Forma sürükle-bırak yöntemiyle kontrol eklemek için kullanılır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w01-a03': ActivityModel(
    id: 'gp-w01-a03',
    type: ActivityType.choice,
    title: 'Yeni Proje Adımları (K6)',
    skill: 'workflow_knowledge',
    cognitiveLevel: 'understand',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Visual Studio\'da yeni bir Windows Forms projesi oluşturmanın doğru adım sırası hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'Şablon seç → Visual Studio\'yu aç → Projeyi isimlendir → Oluştur\'a bas'),
        ActivityOption(id: 'b', text: 'Visual Studio\'yu aç → "Yeni Proje Oluştur"a tıkla → Windows Forms şablonunu seç → İsimlendirip Oluştur\'a bas'),
        ActivityOption(id: 'c', text: 'Projeyi isimlendir → Visual Studio\'yu aç → Şablon seç → Çalıştır'),
        ActivityOption(id: 'd', text: 'Visual Studio\'yu aç → Doğrudan kod yaz → Şablonu sonradan seç'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Visual Studio\'yu açtıktan sonra "Yeni Proje Oluştur" seçeneği ile şablonlar listelenir. Windows Forms App (.NET) şablonu seçilir, ardından proje adlandırılarak Oluştur\'a basılır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w01-a04': ActivityModel(
    id: 'gp-w01-a04',
    type: ActivityType.choice,
    title: 'Solution Explorer Paneli (K1)',
    skill: 'concept_recognition',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          '"Solution Explorer" paneli Visual Studio\'da hangi işlev için kullanılır?',
      options: [
        ActivityOption(id: 'a', text: 'Formun görsel tasarımını değiştirmek'),
        ActivityOption(id: 'b', text: 'Projedeki tüm dosya ve klasörlerin hiyerarşisini görmek ve yönetmek'),
        ActivityOption(id: 'c', text: 'Koda hata ayıklama noktaları (breakpoint) eklemek'),
        ActivityOption(id: 'd', text: 'Seçili kontrolün rengini değiştirmek'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Solution Explorer, projenizin tüm dosyalarını (Form1.cs, Program.cs, referanslar vb.) ağaç yapısında listeler. Buradan dosyalara çift tıklayarak açabilir ve proje yapısını yönetebilirsiniz.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w01-a05': ActivityModel(
    id: 'gp-w01-a05',
    type: ActivityType.choice,
    title: 'Design Time vs Run Time (K2)',
    skill: 'concept_distinction',
    cognitiveLevel: 'understand',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          '"Design Time" ve "Run Time" kavramları arasındaki temel fark nedir?',
      options: [
        ActivityOption(id: 'a', text: 'İkisi aynı şeyi ifade eder, aralarında fark yoktur'),
        ActivityOption(id: 'b', text: 'Design Time; kodun yazıldığı ve formun tasarlandığı evre, Run Time ise programın çalıştığı evredir'),
        ActivityOption(id: 'c', text: 'Design Time programın çalıştığı, Run Time ise hata ayıklama evresidir'),
        ActivityOption(id: 'd', text: 'Design Time yalnızca görsel düzenlemeler için, Run Time yalnızca veritabanı işlemleri içindir'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Design Time, geliştiricinin IDE\'de formu tasarladığı ve kodu yazdığı dönemdir. Run Time ise derlenmiş programın kullanıcı tarafından çalıştırıldığı dönemdir. Bazı özellikler yalnızca Run Time\'da değiştirilebilir.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 2 — Temel Kontroller
  // ══════════════════════════════════════════
  'gp-w02-a01': ActivityModel(
    id: 'gp-w02-a01',
    type: ActivityType.choice,
    title: 'Name vs Text Özelliği (K2)',
    skill: 'property_distinction',
    cognitiveLevel: 'understand',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Bir Button kontrolünün "Name" ve "Text" özellikleri arasındaki fark nedir?',
      options: [
        ActivityOption(id: 'a', text: 'İkisi de kullanıcıya görünen yazıyı belirler'),
        ActivityOption(id: 'b', text: 'Name; kontrolün kod içindeki benzersiz kimliği, Text ise butonun üzerinde görünen yazıdır'),
        ActivityOption(id: 'c', text: 'Name; butonun rengi, Text ise boyutudur'),
        ActivityOption(id: 'd', text: 'Name yalnızca Label, Text yalnızca Button için geçerlidir'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Name, kontrole kod bloğundan erişmek için kullanılan değişken adıdır (örn: btnHesapla). Text ise butonun yüzeyinde kullanıcının gördüğü yazıdır (örn: "Hesapla"). Name değiştirmek kodu etkiler, Text değiştirmek yalnızca görünümü.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w02-a02': ActivityModel(
    id: 'gp-w02-a02',
    type: ActivityType.choice,
    title: 'İsimlendirme Standardı (K8)',
    skill: 'naming_convention',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcı adı girilecek bir TextBox\'ın Name değeri, isimlendirme standartlarına göre nasıl olmalıdır?',
      options: [
        ActivityOption(id: 'a', text: 'KullaniciAdi'),
        ActivityOption(id: 'b', text: 'txtKullaniciAdi'),
        ActivityOption(id: 'c', text: 'textbox1'),
        ActivityOption(id: 'd', text: 'TextBoxKullaniciAdi'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Windows Forms isimlendirme konvansiyonuna göre TextBox için "txt", Button için "btn", Label için "lbl" öneki kullanılır. txtKullaniciAdi bu standardı doğru uygular.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w02-a03': ActivityModel(
    id: 'gp-w02-a03',
    type: ActivityType.choice,
    title: 'TextBox Özelliği (K1)',
    skill: 'concept_recognition',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'TextBox kontrolünde kullanıcının yazdığı metni C# kodunda okumak için hangi özellik kullanılır?',
      options: [
        ActivityOption(id: 'a', text: 'txtAd.Name'),
        ActivityOption(id: 'b', text: 'txtAd.Value'),
        ActivityOption(id: 'c', text: 'txtAd.Text'),
        ActivityOption(id: 'd', text: 'txtAd.Content'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'TextBox kontrolünde kullanıcının girdiği metin .Text özelliğiyle okunur. Örnek: string ad = txtAd.Text; Bu, Windows Forms\'un temel veri okuma yöntemidir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w02-a04': ActivityModel(
    id: 'gp-w02-a04',
    type: ActivityType.choice,
    title: 'Label Kontrolü (K7)',
    skill: 'control_selection',
    cognitiveLevel: 'apply',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcıya yalnızca bilgi göstermek (kullanıcı değiştiremesin) istiyorsunuz. Hangi kontrolü kullanmak daha uygundur?',
      options: [
        ActivityOption(id: 'a', text: 'TextBox'),
        ActivityOption(id: 'b', text: 'Button'),
        ActivityOption(id: 'c', text: 'Label'),
        ActivityOption(id: 'd', text: 'ComboBox'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'Label, yalnızca kullanıcıya bilgi göstermeye yarar; kullanıcı Label içeriğini doğrudan düzenleyemez. Kod içinden lblSonuc.Text = "..."; ile güncellenir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w02-a05': ActivityModel(
    id: 'gp-w02-a05',
    type: ActivityType.choice,
    title: 'Multiline TextBox (K7)',
    skill: 'property_usage',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcıdan birden fazla satır metin almak istiyorsunuz. Hangi özelliği etkinleştirmeniz gerekir?',
      options: [
        ActivityOption(id: 'a', text: 'TextBox.WordWrap = true'),
        ActivityOption(id: 'b', text: 'TextBox.Multiline = true'),
        ActivityOption(id: 'c', text: 'TextBox.ScrollBars = Vertical'),
        ActivityOption(id: 'd', text: 'TextBox.ReadOnly = false'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Bir TextBox\'ın birden fazla satır kabul etmesi için Multiline özelliğini true yapmanız gerekir. Ardından kontrolü boyutlandırarak çok satırlı giriş alanı oluşturabilirsiniz.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 3 — Olaylar (Events) ve OGP
  // ══════════════════════════════════════════
  'gp-w03-a01': ActivityModel(
    id: 'gp-w03-a01',
    type: ActivityType.choice,
    title: 'OGP Tanımı (K1)',
    skill: 'concept_recognition',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Olay Güdümlü Programlama (OGP) paradigması aşağıdakilerden hangisini ifade eder?',
      options: [
        ActivityOption(id: 'a', text: 'Programın üstten alta sıralı biçimde çalışması'),
        ActivityOption(id: 'b', text: 'Programın; kullanıcı eylemleri, sistem mesajları veya sensör tetiklemeleri gibi olaylara tepki vererek çalışması'),
        ActivityOption(id: 'c', text: 'Programın yalnızca veritabanı işlemleri yapması'),
        ActivityOption(id: 'd', text: 'Programın paralel iş parçacıklarıyla çalışması'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'OGP\'de programın akışını kod değil, kullanıcı etkileşimleri (tıklama, yazma vb.) yönlendirir. Buton tıklandığında hangi kodun çalışacağı, o butona bağlı event handler tarafından belirlenir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w03-a02': ActivityModel(
    id: 'gp-w03-a02',
    type: ActivityType.choice,
    title: 'Event Handler İmzası (K3)',
    skill: 'code_reading',
    cognitiveLevel: 'analyze',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki event handler imzasında "sender" parametresi ne anlama gelir?',
      codeSnippet:
          'private void btnHesapla_Click(object sender, EventArgs e)\n{\n    // kod buraya\n}',
      options: [
        ActivityOption(id: 'a', text: 'Olayın tetiklendiği andaki zaman bilgisi'),
        ActivityOption(id: 'b', text: 'Olayı tetikleyen kontrolün (buton, label vb.) kendisi'),
        ActivityOption(id: 'c', text: 'Kullanıcının klavye giriş değeri'),
        ActivityOption(id: 'd', text: 'Formun adı'),
      ],
      correctOptionIds: ['b'],
      explanation:
          '"sender" parametresi, olayı ateşleyen kontrolü temsil eder. Örneğin bir Click olayında sender, tıklanan Button nesnesidir. Aynı handler birden fazla buton için kullanılırsa (Button)sender ile hangi butonun tıklandığı bulunabilir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w03-a03': ActivityModel(
    id: 'gp-w03-a03',
    type: ActivityType.choice,
    title: 'String Birleştirme Çıktısı (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki kod çalıştığında lblSonuc üzerinde ne görünür?',
      codeSnippet:
          'string ad = "Ali";\nstring soyad = "Yılmaz";\nlblSonuc.Text = "Merhaba, " + ad + " " + soyad + "!";',
      options: [
        ActivityOption(id: 'a', text: 'Merhaba, AliYılmaz!'),
        ActivityOption(id: 'b', text: 'Merhaba, Ali Yılmaz!'),
        ActivityOption(id: 'c', text: '"Merhaba, " + ad + " " + soyad + "!"'),
        ActivityOption(id: 'd', text: 'Hata — string birleştirme bu şekilde yapılamaz'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'String birleştirmede + operatörü tüm parçaları sırayla birleştirir. "Merhaba, " + "Ali" + " " + "Yılmaz" + "!" = "Merhaba, Ali Yılmaz!" sonucunu üretir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w03-a04': ActivityModel(
    id: 'gp-w03-a04',
    type: ActivityType.choice,
    title: 'Yanlış Event Bağlantısı (K4)',
    skill: 'error_detection',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Bir geliştirici forma eklediği butona çift tıklıyor ancak kod çalışmıyor. Büyük olasılıkla sorun nedir?',
      options: [
        ActivityOption(id: 'a', text: 'C# diline özgü sözdizimi hatası'),
        ActivityOption(id: 'b', text: 'Butonun Name özelliği boş bırakılmış'),
        ActivityOption(id: 'c', text: 'Event handler oluşturulmuş ama butonun Click olayına bağlanmamış veya kodun içi boş'),
        ActivityOption(id: 'd', text: 'Formun boyutu çok küçük'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'Visual Studio\'da butona çift tıklamak boş bir Click event handler oluşturur; bu handler içine kod yazılmazsa hiçbir şey olmaz. Ayrıca nadiren handler doğru olayda değil, yanlış olayda tanımlı olabilir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w03-a05': ActivityModel(
    id: 'gp-w03-a05',
    type: ActivityType.choice,
    title: 'Metin Temizleme (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcı "Temizle" butonuna bastığında hem TextBox içeriğini hem de Label metnini silmek istiyorsunuz. Doğru kod hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'txtAd.Clear();\nlblSonuc.Clear();'),
        ActivityOption(id: 'b', text: 'txtAd.Text = "";\nlblSonuc.Text = "";'),
        ActivityOption(id: 'c', text: 'txtAd.Delete();\nlblSonuc.Delete();'),
        ActivityOption(id: 'd', text: 'txtAd.Text = null;\nlblSonuc.Text = null;'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'TextBox için hem txtAd.Text = ""; hem de txtAd.Clear(); çalışır. Ancak Label\'ın Clear() metodu yoktur; lblSonuc.Text = ""; kullanılmalıdır. Bu nedenle iki kontrol için de .Text = "" yaklaşımı tutarlı ve güvenlidir.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 4 — Değişkenler ve string Tipi
  // ══════════════════════════════════════════
  'gp-w04-a01': ActivityModel(
    id: 'gp-w04-a01',
    type: ActivityType.choice,
    title: 'Değişken Tanımlama (K8)',
    skill: 'variable_declaration',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'C#\'ta "Ahmet" değerini tutan bir string değişkeni doğru şekilde tanımlamak için aşağıdakilerden hangisi kullanılmalıdır?',
      options: [
        ActivityOption(id: 'a', text: 'string ad = Ahmet;'),
        ActivityOption(id: 'b', text: 'String = "Ahmet";'),
        ActivityOption(id: 'c', text: 'string ad = "Ahmet";'),
        ActivityOption(id: 'd', text: 'var "Ahmet" = ad;'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'C#\'ta string değişkeni: tip adı (string), değişken adı (ad), atama operatörü (=) ve çift tırnaklar içindeki değer ("Ahmet") olmak üzere dört bileşenden oluşur.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w04-a02': ActivityModel(
    id: 'gp-w04-a02',
    type: ActivityType.choice,
    title: 'string.ToUpper() Çıktısı (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki kod çalıştığında lblSonuc ne gösterir?',
      codeSnippet: 'string sehir = "ankara";\nlblSonuc.Text = sehir.ToUpper();',
      options: [
        ActivityOption(id: 'a', text: 'ankara'),
        ActivityOption(id: 'b', text: 'Ankara'),
        ActivityOption(id: 'c', text: 'ANKARA'),
        ActivityOption(id: 'd', text: 'aNKARA'),
      ],
      correctOptionIds: ['c'],
      explanation:
          '.ToUpper() metodu, string içindeki tüm harfleri büyüğe dönüştürür. "ankara" → "ANKARA". Benzer şekilde .ToLower() tüm harfleri küçük yapar.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w04-a03': ActivityModel(
    id: 'gp-w04-a03',
    type: ActivityType.choice,
    title: 'string.Length Kullanımı (K2)',
    skill: 'property_distinction',
    cognitiveLevel: 'understand',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          '"Merhaba" kelimesinin karakter sayısını döndüren C# ifadesi hangisidir?',
      options: [
        ActivityOption(id: 'a', text: '"Merhaba".Count()'),
        ActivityOption(id: 'b', text: '"Merhaba".Length'),
        ActivityOption(id: 'c', text: '"Merhaba".Size()'),
        ActivityOption(id: 'd', text: '"Merhaba".Chars'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'string sınıfında karakter sayısını veren özellik .Length\'dir. "Merhaba".Length → 7. Boşluk karakterleri de sayıya dahil edilir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w04-a04': ActivityModel(
    id: 'gp-w04-a04',
    type: ActivityType.choice,
    title: 'Kapsam (Scope) Hatası (K4)',
    skill: 'error_detection',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki kodun hangi satırında hata vardır ve nedeni nedir?',
      codeSnippet:
          'private void btnHesapla_Click(object sender, EventArgs e)\n{\n    string mesaj = "Hoş geldiniz!";\n}\n\nprivate void btnGoster_Click(object sender, EventArgs e)\n{\n    lblSonuc.Text = mesaj; // ← bu satır\n}',
      options: [
        ActivityOption(id: 'a', text: 'Hata yok, kod doğrudur'),
        ActivityOption(id: 'b', text: '"mesaj" değişkeni btnHesapla_Click metoduna ait yerel bir değişkendir; btnGoster_Click içinden erişilemez'),
        ActivityOption(id: 'c', text: 'lblSonuc\'un Text özelliği string atamayı kabul etmez'),
        ActivityOption(id: 'd', text: 'btnGoster_Click metodunun parametreleri yanlıştır'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Bir metot içinde tanımlanan değişken o metodun dışından erişilemez (kapsam / scope kuralı). "mesaj"ın her iki metottan da erişilebilir olması için sınıf seviyesinde (field) tanımlanması gerekir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w04-a05': ActivityModel(
    id: 'gp-w04-a05',
    type: ActivityType.choice,
    title: 'Trim() Metodu (K8)',
    skill: 'method_knowledge',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcının TextBox\'a "  Ali  " (baş ve sondaki boşluklarla) yazdığını varsayalım. Yalnızca "Ali" değerini elde etmek için aşağıdakilerden hangisi kullanılmalıdır?',
      options: [
        ActivityOption(id: 'a', text: 'txtAd.Text.Remove()'),
        ActivityOption(id: 'b', text: 'txtAd.Text.Strip()'),
        ActivityOption(id: 'c', text: 'txtAd.Text.Trim()'),
        ActivityOption(id: 'd', text: 'txtAd.Text.Clear()'),
      ],
      correctOptionIds: ['c'],
      explanation:
          '.Trim() metodu stringin baş ve sonundaki boşluk karakterlerini siler. "  Ali  ".Trim() → "Ali". TrimStart() yalnızca başı, TrimEnd() yalnızca sonu temizler.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 5 — Sayısal Tipler ve İşlemler
  // ══════════════════════════════════════════
  'gp-w05-a01': ActivityModel(
    id: 'gp-w05-a01',
    type: ActivityType.choice,
    title: 'int Bölme Sonucu (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'analyze',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki kod çalıştığında ekranda ne görünür?',
      codeSnippet: 'int x = 7;\nint y = 2;\nlblSonuc.Text = (x / y).ToString();',
      options: [
        ActivityOption(id: 'a', text: '3,5'),
        ActivityOption(id: 'b', text: '3'),
        ActivityOption(id: 'c', text: '3.5'),
        ActivityOption(id: 'd', text: '4'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'C#\'ta iki int sayı bölündüğünde sonuç da int olur ve ondalık kısım atılır. 7 / 2 = 3 (tam bölme). Ondalıklı sonuç için en az bir taraf double olmalıdır: (double)x / y veya 7.0 / 2.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w05-a02': ActivityModel(
    id: 'gp-w05-a02',
    type: ActivityType.choice,
    title: 'Modulo (%) Operatörü (K1)',
    skill: 'operator_knowledge',
    cognitiveLevel: 'understand',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: '17 % 5 işleminin sonucu nedir ve bu operatörün amacı nedir?',
      options: [
        ActivityOption(id: 'a', text: '3 — Tam bölüm sonucunu verir'),
        ActivityOption(id: 'b', text: '3 — Bölme işleminin kalanını verir (17 = 3×5 + 2, kalan 2)'),
        ActivityOption(id: 'c', text: '2 — Bölme işleminin kalanını verir'),
        ActivityOption(id: 'd', text: '3,4 — Ondalıklı bölme sonucunu verir'),
      ],
      correctOptionIds: ['c'],
      explanation:
          '% (modulo) operatörü bölme işleminin kalanını verir. 17 ÷ 5 = 3 kalan 2, dolayısıyla 17 % 5 = 2. Kullanım alanları: çift/tek sayı tespiti (n % 2 == 0), döngüde belirli aralıkta tekrar (i % 5 == 0).',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w05-a03': ActivityModel(
    id: 'gp-w05-a03',
    type: ActivityType.choice,
    title: 'int vs double Seçimi (K7)',
    skill: 'type_selection',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Bir alışveriş uygulamasında ürün fiyatını (örn. 49,90 ₺) saklamak için hangi veri tipi tercih edilmelidir?',
      options: [
        ActivityOption(id: 'a', text: 'int — Tamsayı yeterlidir'),
        ActivityOption(id: 'b', text: 'string — Sayıları her zaman metin olarak saklamalıyız'),
        ActivityOption(id: 'c', text: 'double veya decimal — Ondalıklı değerleri tutabilmek için'),
        ActivityOption(id: 'd', text: 'bool — Fiyatın var olup olmadığını göstermek için'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'Parasal değerler için double veya (daha hassas hesaplama gerektiren durumlarda) decimal kullanılır. int yalnızca tam sayılar için uygundur; 49,90 gibi ondalıklı değerleri tutamaz.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w05-a04': ActivityModel(
    id: 'gp-w05-a04',
    type: ActivityType.choice,
    title: 'ToString("F2") Formatlama (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki kod çalıştığında lblFiyat ne gösterir?',
      codeSnippet: 'double fiyat = 15.7;\nlblFiyat.Text = fiyat.ToString("F2") + " ₺";',
      options: [
        ActivityOption(id: 'a', text: '15,7 ₺'),
        ActivityOption(id: 'b', text: '15.70 ₺'),
        ActivityOption(id: 'c', text: '15,70 ₺'),
        ActivityOption(id: 'd', text: '15 ₺'),
      ],
      correctOptionIds: ['c'],
      explanation:
          '"F2" formatı, sayıyı 2 ondalık basamakla gösterir. Türk kültür ayarlarında (tr-TR) ondalık ayracı virgül olduğu için 15,70 görünür. Nokta görünmesi için kültür ayarı değiştirilmelidir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w05-a05': ActivityModel(
    id: 'gp-w05-a05',
    type: ActivityType.choice,
    title: 'KDV Hesabı Senaryosu (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcı TextBox\'a ürün fiyatını giriyor. %18 KDV eklenmiş fiyatı Label\'da göstermek istiyorsunuz. Doğru hesaplama hangisidir?',
      codeSnippet: 'double fiyat = double.Parse(txtFiyat.Text);',
      options: [
        ActivityOption(id: 'a', text: 'double kdvliFiyat = fiyat + 18;'),
        ActivityOption(id: 'b', text: 'double kdvliFiyat = fiyat * 18;'),
        ActivityOption(id: 'c', text: 'double kdvliFiyat = fiyat * 1.18;'),
        ActivityOption(id: 'd', text: 'double kdvliFiyat = fiyat / 0.18;'),
      ],
      correctOptionIds: ['c'],
      explanation:
          '%18 KDV eklemek; orijinal fiyatın 1.18 katını almak demektir. fiyat * 1.18 = fiyat + (fiyat × 0.18). Örnek: 100 ₺ × 1.18 = 118 ₺.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 6 — Tip Dönüşümleri ve try-catch
  // ══════════════════════════════════════════
  'gp-w06-a01': ActivityModel(
    id: 'gp-w06-a01',
    type: ActivityType.choice,
    title: 'Parse vs Convert (K2)',
    skill: 'method_distinction',
    cognitiveLevel: 'understand',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'int.Parse() ve Convert.ToInt32() arasındaki en önemli davranış farkı nedir?',
      options: [
        ActivityOption(id: 'a', text: 'int.Parse() daha hızlıdır, Convert.ToInt32() daha yavaştır'),
        ActivityOption(id: 'b', text: 'int.Parse(null) NullReferenceException fırlatır; Convert.ToInt32(null) ise 0 döner'),
        ActivityOption(id: 'c', text: 'Convert.ToInt32() yalnızca double\'dan int\'e dönüşüm için kullanılır'),
        ActivityOption(id: 'd', text: 'Aralarında hiçbir işlevsel fark yoktur'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'int.Parse(null) → NullReferenceException, int.Parse("") → FormatException fırlatır. Convert.ToInt32(null) ise 0 döner (hata fırlatmaz). Bu fark özellikle kullanıcı girdisi işlerken önemlidir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w06-a02': ActivityModel(
    id: 'gp-w06-a02',
    type: ActivityType.choice,
    title: 'FormatException Nedenini Bul (K4)',
    skill: 'error_detection',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcı TextBox\'a "abc" yazdığında aşağıdaki kod FormatException hatası verir. Çözüm nedir?',
      codeSnippet: 'int sayi = int.Parse(txtSayi.Text);\nlblSonuc.Text = (sayi * 2).ToString();',
      options: [
        ActivityOption(id: 'a', text: 'int yerine string kullanmak'),
        ActivityOption(id: 'b', text: 'Kodu try-catch bloğuyla sararak hatalı girişi yakalamak ve kullanıcıya mesaj göstermek'),
        ActivityOption(id: 'c', text: 'Parse yerine Convert.ToString() kullanmak'),
        ActivityOption(id: 'd', text: 'TextBox\'ı ReadOnly yapmak'),
      ],
      correctOptionIds: ['b'],
      explanation:
          '"abc" sayısal bir ifade olmadığından int.Parse() FormatException fırlatır. Çözüm: try { ... } catch (FormatException) { MessageBox.Show("Lütfen sayı giriniz!"); } bloğu.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w06-a03': ActivityModel(
    id: 'gp-w06-a03',
    type: ActivityType.choice,
    title: 'try-catch Bloğu Yapısı (K6)',
    skill: 'syntax_knowledge',
    cognitiveLevel: 'remember',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'C#\'ta try-catch bloğunun doğru yazımı hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'try { } error { }'),
        ActivityOption(id: 'b', text: 'attempt { } rescue { }'),
        ActivityOption(id: 'c', text: 'try { } catch (Exception ex) { }'),
        ActivityOption(id: 'd', text: 'guard { } handle { }'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'C#\'ta hata yönetimi try { /* riskli kod */ } catch (Exception ex) { /* hata yönetimi */ } yapısıyla yapılır. İsteğe bağlı olarak finally { /* her durumda çalışacak kod */ } eklenebilir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w06-a04': ActivityModel(
    id: 'gp-w06-a04',
    type: ActivityType.choice,
    title: 'Güvenli Dönüşüm Senaryosu (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Bir hesap makinesi uygulamasında kullanıcı boş TextBox ile hesapla butonuna basabilir. En güvenli yaklaşım hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'int.Parse() kullanmak ve olası hatayı görmezden gelmek'),
        ActivityOption(id: 'b', text: 'int.TryParse() ile girişi doğrulamak; başarısız olursa kullanıcıya uyarı göstermek'),
        ActivityOption(id: 'c', text: 'TextBox\'ı tamamen kaldırıp yalnızca ComboBox kullanmak'),
        ActivityOption(id: 'd', text: 'Hesapla butonunu disabled bırakmak'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'int.TryParse(txtSayi.Text, out int sayi) hem dönüşümü dener hem de başarı durumunu bool olarak döner. Hata fırlatmadığı için try-catch gerekmez ve daha temiz bir kod sağlar.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w06-a05': ActivityModel(
    id: 'gp-w06-a05',
    type: ActivityType.choice,
    title: 'TryParse Çıktısı (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki kod çalıştığında lblSonuc ne gösterir?',
      codeSnippet:
          'string giris = "42abc";\nif (int.TryParse(giris, out int sayi))\n    lblSonuc.Text = "Başarılı: " + sayi;\nelse\n    lblSonuc.Text = "Geçersiz giriş";',
      options: [
        ActivityOption(id: 'a', text: 'Başarılı: 42'),
        ActivityOption(id: 'b', text: 'Başarılı: 0'),
        ActivityOption(id: 'c', text: 'Geçersiz giriş'),
        ActivityOption(id: 'd', text: 'FormatException hatası'),
      ],
      correctOptionIds: ['c'],
      explanation:
          '"42abc" tam olarak bir sayı değildir; TryParse bu durumda false döner ve sayi değişkeni 0 olur. else bloğu çalışır: "Geçersiz giriş".',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 7 — İlk 6 Hafta Entegrasyonu
  // ══════════════════════════════════════════
  'gp-w07-a01': ActivityModel(
    id: 'gp-w07-a01',
    type: ActivityType.choice,
    title: 'Para Formatlama (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki kod çalıştığında lblFiyat ne gösterir?',
      codeSnippet:
          'double toplam = 1250.5;\nlblFiyat.Text = toplam.ToString("C", new System.Globalization.CultureInfo("tr-TR"));',
      options: [
        ActivityOption(id: 'a', text: '1250.5'),
        ActivityOption(id: 'b', text: '1.250,50 ₺'),
        ActivityOption(id: 'c', text: '₺1,250.50'),
        ActivityOption(id: 'd', text: '1250,50'),
      ],
      correctOptionIds: ['b'],
      explanation:
          '"C" formatı ile tr-TR kültürü kullanıldığında sayı Türkçe para formatında gösterilir: binlik ayracı nokta, ondalık ayracı virgül, para birimi simgesi ₺.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w07-a02': ActivityModel(
    id: 'gp-w07-a02',
    type: ActivityType.choice,
    title: 'Çok Kontrolü Birleştirme (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Bir fatura uygulamasında "Hesapla" butonu tıklandığında; TextBox\'dan ürün adını, fiyatını ve miktarını okuyup toplamı Label\'da göstermek istiyorsunuz. Hangi sıralama doğrudur?',
      options: [
        ActivityOption(id: 'a', text: 'Toplamı göster → Miktarı oku → Fiyatı oku → Ürün adını oku'),
        ActivityOption(id: 'b', text: 'Ürün adını ve sayısal değerleri oku → Hesapla → Sonucu Label\'da göster'),
        ActivityOption(id: 'c', text: 'Label\'ı temizle → Butonu devre dışı bırak → Değerleri oku'),
        ActivityOption(id: 'd', text: 'Toplamı Label\'a yaz → TextBox\'ları parse et'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Doğru akış: (1) Girdileri oku/parse et, (2) Hesaplamayı yap, (3) Sonucu Label\'a yaz. Çıktıyı girdi okumadan önce yazmak hatalı veri göstermek anlamına gelir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w07-a03': ActivityModel(
    id: 'gp-w07-a03',
    type: ActivityType.choice,
    title: 'Temizle Butonu (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          '"Temizle" butonu; txtUrun, txtFiyat, txtMiktar ve lblToplam kontrollerini sıfırlamalıdır. Hangisi eksik veya yanlış?',
      codeSnippet:
          'txtUrun.Text = "";\ntxtFiyat.Text = "";\ntxtMiktar.Text = "";\nlblToplam.Clear(); // ← bu satır',
      options: [
        ActivityOption(id: 'a', text: 'Hiçbir sorun yok, kod doğru'),
        ActivityOption(id: 'b', text: 'lblToplam.Clear() yanlış; Label\'ın Clear() metodu yok, lblToplam.Text = "" olmalı'),
        ActivityOption(id: 'c', text: 'txtUrun.Text = "" yerine txtUrun.Clear() kullanılmalı'),
        ActivityOption(id: 'd', text: 'Tüm TextBox\'lar için Clear() kullanılmalıydı, Text = "" değil'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Label sınıfı Clear() metoduna sahip değildir. Yalnızca TextBox, RichTextBox gibi metin giriş kontrolleri Clear() metodunu destekler. Label için .Text = "" kullanılmalıdır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w07-a04': ActivityModel(
    id: 'gp-w07-a04',
    type: ActivityType.choice,
    title: 'Çoklu Kontrol Adlandırma (K2)',
    skill: 'naming_convention',
    cognitiveLevel: 'apply',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Bir formda 3 farklı hesaplama butonu var: Toplama, Çıkarma ve Çarpma. Doğru adlandırma hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'button1, button2, button3'),
        ActivityOption(id: 'b', text: 'btnToplama, btnCikarma, btnCarpma'),
        ActivityOption(id: 'c', text: 'ToplaBut, CikartBut, CarpBut'),
        ActivityOption(id: 'd', text: 'hesapla1, hesapla2, hesapla3'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Windows Forms konvansiyonunda butonlar btn öneki ile başlar; btn + anlamlı isim. button1, button2 gibi otomatik adlar anlaşılırlığı düşürür.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w07-a05': ActivityModel(
    id: 'gp-w07-a05',
    type: ActivityType.choice,
    title: 'UI Geri Bildirim Tasarımı (K7)',
    skill: 'ui_design',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcı hatalı giriş yaptığında uyarı göstermek için hangisi en kullanışlı yöntemdir?',
      options: [
        ActivityOption(id: 'a', text: 'Programı kapatmak'),
        ActivityOption(id: 'b', text: 'Hiçbir şey yapmamak, hata sessizce geçsin'),
        ActivityOption(id: 'c', text: 'MessageBox.Show() ile açıklayıcı bir uyarı mesajı göstermek'),
        ActivityOption(id: 'd', text: 'Tüm TextBox\'ları silmek'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'MessageBox.Show("Lütfen geçerli bir sayı giriniz!") kullanıcıya anlaşılır geri bildirim sağlar. Hataları sessizce geçmek kullanıcı deneyimini bozar.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 8 — if ve if-else
  // ══════════════════════════════════════════
  'gp-w08-a01': ActivityModel(
    id: 'gp-w08-a01',
    type: ActivityType.choice,
    title: 'if Sözdizimi (K8)',
    skill: 'syntax_knowledge',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'C#\'ta doğru if-else sözdizimi hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'if x > 5 then { } else { }'),
        ActivityOption(id: 'b', text: 'if (x > 5) { } else { }'),
        ActivityOption(id: 'c', text: 'if [x > 5] { } otherwise { }'),
        ActivityOption(id: 'd', text: 'when (x > 5) { } fallback { }'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'C#\'ta koşul parantez içine yazılır: if (koşul) { }. "then" anahtar kelimesi yoktur. else bloğu isteğe bağlıdır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w08-a02': ActivityModel(
    id: 'gp-w08-a02',
    type: ActivityType.choice,
    title: 'if Çıktısı Tahmini (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'x = 10 iken aşağıdaki kod çalıştığında lblSonuc ne gösterir?',
      codeSnippet:
          'int x = 10;\nif (x > 5)\n    lblSonuc.Text = "Büyük";\nelse\n    lblSonuc.Text = "Küçük veya Eşit";',
      options: [
        ActivityOption(id: 'a', text: 'Küçük veya Eşit'),
        ActivityOption(id: 'b', text: 'Büyük'),
        ActivityOption(id: 'c', text: 'Her ikisi birden'),
        ActivityOption(id: 'd', text: 'Boş kalır'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'x = 10, 10 > 5 koşulu true olduğundan if bloğu çalışır: lblSonuc.Text = "Büyük".',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w08-a03': ActivityModel(
    id: 'gp-w08-a03',
    type: ActivityType.choice,
    title: '&& ve || Operatörleri (K7)',
    skill: 'operator_usage',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Bir kullanıcının sisteme girişine izin vermek için hem yaşının 18 veya üzeri hem de onaylı üye olması gerekiyor. Doğru koşul hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'if (yas >= 18 || onayliUye)'),
        ActivityOption(id: 'b', text: 'if (yas >= 18 && onayliUye)'),
        ActivityOption(id: 'c', text: 'if (yas > 18 || onayliUye)'),
        ActivityOption(id: 'd', text: 'if (yas == 18 && onayliUye)'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Her iki koşulun da sağlanması gerektiğinden AND operatörü (&&) kullanılır. || (OR) olsaydı yalnızca biri sağlansa da giriş izni verilirdi.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w08-a04': ActivityModel(
    id: 'gp-w08-a04',
    type: ActivityType.choice,
    title: 'Hatalı Koşul (K4)',
    skill: 'error_detection',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki kodda semantik (mantık) hatası nedir?',
      codeSnippet:
          'int not = 85;\nif (not = 100)\n    lblSonuc.Text = "Tam puan!";',
      options: [
        ActivityOption(id: 'a', text: 'not değişkeni int olamaz'),
        ActivityOption(id: 'b', text: '"not = 100" atama operatörüdür; karşılaştırma için "==" kullanılmalıdır'),
        ActivityOption(id: 'c', text: 'lblSonuc.Text atama sözdizimi yanlıştır'),
        ActivityOption(id: 'd', text: 'if bloğu süslü parantez gerektirmez'),
      ],
      correctOptionIds: ['b'],
      explanation:
          '= atama operatörüdür, == karşılaştırma operatörüdür. if (not = 100) → not değişkenine 100 atanır ve bu sayısal değer bool\'a dönüştürülemez; derleme hatası verir. Doğrusu: if (not == 100).',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w08-a05': ActivityModel(
    id: 'gp-w08-a05',
    type: ActivityType.choice,
    title: 'Giriş İzin Senaryosu (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Bir uygulama; kullanıcı adı "admin" VE şifre "1234" ise "Hoş geldiniz!" yazan, değilse "Hatalı giriş!" yazan kod istiyor. Hangisi doğrudur?',
      options: [
        ActivityOption(id: 'a', text: 'if (txtKullanici.Text == "admin" || txtSifre.Text == "1234")'),
        ActivityOption(id: 'b', text: 'if (txtKullanici.Text = "admin" && txtSifre.Text = "1234")'),
        ActivityOption(id: 'c', text: 'if (txtKullanici.Text == "admin" && txtSifre.Text == "1234")'),
        ActivityOption(id: 'd', text: 'if ("admin" = txtKullanici.Text && "1234" = txtSifre.Text)'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'İki koşulun aynı anda sağlanması için && ve karşılaştırma için == kullanılır. = atama operatörüdür, || sadece birinin sağlanmasını gerektirir.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 9 — if-else if Merdiveni
  // ══════════════════════════════════════════
  'gp-w09-a01': ActivityModel(
    id: 'gp-w09-a01',
    type: ActivityType.choice,
    title: 'Not Hesaplama (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'not = 72 iken aşağıdaki kod lblHarf\'e ne yazar?',
      codeSnippet:
          'if (not >= 90)\n    lblHarf.Text = "AA";\nelse if (not >= 80)\n    lblHarf.Text = "BA";\nelse if (not >= 70)\n    lblHarf.Text = "BB";\nelse if (not >= 60)\n    lblHarf.Text = "CB";\nelse\n    lblHarf.Text = "FF";',
      options: [
        ActivityOption(id: 'a', text: 'BA'),
        ActivityOption(id: 'b', text: 'BB'),
        ActivityOption(id: 'c', text: 'CB'),
        ActivityOption(id: 'd', text: 'FF'),
      ],
      correctOptionIds: ['b'],
      explanation:
          '72 >= 90? Hayır. 72 >= 80? Hayır. 72 >= 70? Evet! lblHarf.Text = "BB". Zincir ilk true koşulda durur.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w09-a02': ActivityModel(
    id: 'gp-w09-a02',
    type: ActivityType.choice,
    title: 'Sıralama Önemi (K7)',
    skill: 'logic_order',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki if-else if zinciri neden hatalı çalışabilir?',
      codeSnippet:
          'if (not >= 60)\n    lblHarf.Text = "CB";\nelse if (not >= 80)\n    lblHarf.Text = "BA";\nelse if (not >= 90)\n    lblHarf.Text = "AA";',
      options: [
        ActivityOption(id: 'a', text: 'Hiçbir sorun yok, kod doğru sıralıdır'),
        ActivityOption(id: 'b', text: 'Koşullar küçükten büyüğe sıralanmış; not = 95 gibi yüksek değerler yanlışlıkla "CB" alabilir'),
        ActivityOption(id: 'c', text: 'else if sözdizimi yanlış yazılmış'),
        ActivityOption(id: 'd', text: 'C# birden fazla else if\'e izin vermez'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'İlk koşul (>= 60) çok geniş; 60, 70, 80, 90+ tüm değerler buna girer ve zincir orada durur. Doğru yaklaşım: önce büyük eşik (>= 90), sonra küçük eşikler yazılmalıdır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w09-a03': ActivityModel(
    id: 'gp-w09-a03',
    type: ActivityType.choice,
    title: 'BMI Kategorisi Senaryosu (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'BMI = 22.5 için hangi mesaj görünmelidir? (Normal: 18.5–24.9, Fazla kilo: 25–29.9, Obez: ≥30, Zayıf: <18.5)',
      options: [
        ActivityOption(id: 'a', text: 'Fazla kilo'),
        ActivityOption(id: 'b', text: 'Normal kilolu'),
        ActivityOption(id: 'c', text: 'Obez'),
        ActivityOption(id: 'd', text: 'Zayıf'),
      ],
      correctOptionIds: ['b'],
      explanation:
          '22.5 değeri 18.5–24.9 aralığında olduğundan "Normal kilolu" kategorisine girer. if-else if zincirinde koşullar sırası kritik: önce en kısıtlayıcı koşul yazılmalıdır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w09-a04': ActivityModel(
    id: 'gp-w09-a04',
    type: ActivityType.choice,
    title: 'Birden Fazla Koşul (K8)',
    skill: 'condition_writing',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Sıcaklığın 0 ile 100 arasında (uçlar dahil) olup olmadığını kontrol eden doğru koşul hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'if (sicaklik > 0 && sicaklik < 100)'),
        ActivityOption(id: 'b', text: 'if (0 <= sicaklik <= 100)'),
        ActivityOption(id: 'c', text: 'if (sicaklik >= 0 && sicaklik <= 100)'),
        ActivityOption(id: 'd', text: 'if (sicaklik >= 0 || sicaklik <= 100)'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'C#\'ta 0 <= x <= 100 zincir karşılaştırması geçerli değildir. İki ayrı koşul && ile birleştirilmelidir: sicaklik >= 0 && sicaklik <= 100.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w09-a05': ActivityModel(
    id: 'gp-w09-a05',
    type: ActivityType.choice,
    title: 'Gece Ücreti Senaryosu (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Bir taksi uygulamasında saat 22:00–06:00 arası ücrete %30 zam uygulanıyor. Saat = 23 ise hangi koşul doğru çalışır?',
      options: [
        ActivityOption(id: 'a', text: 'if (saat >= 22 && saat <= 6)'),
        ActivityOption(id: 'b', text: 'if (saat >= 22 || saat <= 6)'),
        ActivityOption(id: 'c', text: 'if (saat >= 22 && saat < 24)'),
        ActivityOption(id: 'd', text: 'if (saat > 22 && saat < 6)'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Gece tarifesi iki ayrı aralığı kapsar: 22–23 ve 0–6. Bu durum OR (||) ile temsil edilir: (saat >= 22) || (saat <= 6). AND kullansaydık saat hem >=22 hem <=6 olmak zorunda kalırdı, bu imkânsız.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 10 — switch-case ve Timer
  // ══════════════════════════════════════════
  'gp-w10-a01': ActivityModel(
    id: 'gp-w10-a01',
    type: ActivityType.choice,
    title: 'switch-case Seçim Kriteri (K7)',
    skill: 'control_selection',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki durumlardan hangisi için switch-case yapısı if-else if\'e göre daha uygundur?',
      options: [
        ActivityOption(id: 'a', text: 'Bir sayının pozitif, negatif veya sıfır olduğunu kontrol etmek'),
        ActivityOption(id: 'b', text: 'Bir menü seçeneğini (1: Ekle, 2: Sil, 3: Güncelle) işlemek'),
        ActivityOption(id: 'c', text: 'Kullanıcının yaşının belirli bir aralıkta olup olmadığını kontrol etmek'),
        ActivityOption(id: 'd', text: 'İki koşulu && ile birleştirmek'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'switch-case belirli sabit değerlere (int, string, enum) göre çoklu dallanma için idealdir. Sayısal aralık karşılaştırmaları (> 18 gibi) switch ile doğrudan yapılamaz; if-else if tercih edilir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w10-a02': ActivityModel(
    id: 'gp-w10-a02',
    type: ActivityType.choice,
    title: 'switch break Eksikliği (K4)',
    skill: 'error_detection',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'C#\'ta switch-case içinde break; satırının atlanması ne sonuç verir?',
      options: [
        ActivityOption(id: 'a', text: 'Herhangi bir etkisi yoktur, bir sonraki case\'e geçmez'),
        ActivityOption(id: 'b', text: 'Derleme hatası verir; C#\'ta break zorunludur (fall-through yok)'),
        ActivityOption(id: 'c', text: 'Tüm case\'ler sırayla çalışır'),
        ActivityOption(id: 'd', text: 'Yalnızca default bloğu çalışır'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'C#\'ta switch-case\'de açık fall-through (break yazmadan bir sonraki case\'e düşme) derleme hatası verir. Her case; ya break, return ya da goto case ile bitmelidir. Bu, C/Java\'dan farklı bir davranıştır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w10-a03': ActivityModel(
    id: 'gp-w10-a03',
    type: ActivityType.choice,
    title: 'Timer.Tick Olayı (K1)',
    skill: 'concept_recognition',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Windows Forms\'ta Timer kontrolünün Tick olayı ne zaman tetiklenir?',
      options: [
        ActivityOption(id: 'a', text: 'Kullanıcı herhangi bir tuşa bastığında'),
        ActivityOption(id: 'b', text: 'Form açıldığında yalnızca bir kez'),
        ActivityOption(id: 'c', text: 'Timer.Interval özelliğinde belirlenen milisaniye aralıklarla, Timer.Enabled = true olduğu sürece tekrarlayarak'),
        ActivityOption(id: 'd', text: 'Sadece kullanıcı fare hareket ettirdiğinde'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'Timer.Interval (ms cinsinden) süre dolduğunda Tick olayı tetiklenir ve siz durdurana kadar tekrar eder. Timer1.Start() veya Enabled = true ile başlatılır, Timer1.Stop() ile durdurulur.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w10-a04': ActivityModel(
    id: 'gp-w10-a04',
    type: ActivityType.choice,
    title: 'Gün Adı switch-case (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'gun = 3 iken aşağıdaki kod lblGun\'a ne yazar?',
      codeSnippet:
          'switch (gun)\n{\n    case 1: lblGun.Text = "Pazartesi"; break;\n    case 2: lblGun.Text = "Salı"; break;\n    case 3: lblGun.Text = "Çarşamba"; break;\n    default: lblGun.Text = "Bilinmiyor"; break;\n}',
      options: [
        ActivityOption(id: 'a', text: 'Salı'),
        ActivityOption(id: 'b', text: 'Çarşamba'),
        ActivityOption(id: 'c', text: 'Bilinmiyor'),
        ActivityOption(id: 'd', text: '3'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'gun = 3 olduğundan case 3 eşleşir: lblGun.Text = "Çarşamba". break ile switch bloğundan çıkılır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w10-a05': ActivityModel(
    id: 'gp-w10-a05',
    type: ActivityType.choice,
    title: 'Timer Saniye Sayacı (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Her saniyede bir lblSayi\'yı 1 artıran bir sayaç yapmak istiyorsunuz. Timer.Interval değeri ne olmalıdır?',
      options: [
        ActivityOption(id: 'a', text: '1 (1 milisaniye)'),
        ActivityOption(id: 'b', text: '100 (100 milisaniye = 0.1 saniye)'),
        ActivityOption(id: 'c', text: '1000 (1000 milisaniye = 1 saniye)'),
        ActivityOption(id: 'd', text: '60000 (60 saniye)'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'Timer.Interval milisaniye cinsindendir. 1 saniye = 1000 milisaniye; Timer.Interval = 1000 ile her saniyede Tick tetiklenir.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 11 — for Döngüsü ve ListBox
  // ══════════════════════════════════════════
  'gp-w11-a01': ActivityModel(
    id: 'gp-w11-a01',
    type: ActivityType.choice,
    title: 'for Döngüsü Bileşenleri (K1)',
    skill: 'syntax_knowledge',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'for (int i = 0; i < 5; i++) döngüsünde kaç kez döngü gövdesi çalışır?',
      options: [
        ActivityOption(id: 'a', text: '4 kez'),
        ActivityOption(id: 'b', text: '5 kez'),
        ActivityOption(id: 'c', text: '6 kez'),
        ActivityOption(id: 'd', text: 'Sonsuz kez'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'i = 0, 1, 2, 3, 4 değerlerini alır (i < 5 koşulu); 5 olduğunda koşul false olur ve döngü biter. Toplam 5 iterasyon.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w11-a02': ActivityModel(
    id: 'gp-w11-a02',
    type: ActivityType.choice,
    title: 'Toplam Hesaplama for (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki döngü sonunda toplam değişkeninin değeri nedir?',
      codeSnippet: 'int toplam = 0;\nfor (int i = 1; i <= 4; i++)\n    toplam += i;',
      options: [
        ActivityOption(id: 'a', text: '4'),
        ActivityOption(id: 'b', text: '6'),
        ActivityOption(id: 'c', text: '10'),
        ActivityOption(id: 'd', text: '16'),
      ],
      correctOptionIds: ['c'],
      explanation: '1 + 2 + 3 + 4 = 10. Akümülatör mantığı: her adımda toplam += i yapılır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w11-a03': ActivityModel(
    id: 'gp-w11-a03',
    type: ActivityType.choice,
    title: 'ListBox.Items.Add() (K5)',
    skill: 'api_usage',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          '1\'den 5\'e kadar sayıları ListBox\'a eklemek için doğru kod hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'lstSayilar.Add(i);'),
        ActivityOption(id: 'b', text: 'for (int i = 1; i <= 5; i++) lstSayilar.Items.Add(i);'),
        ActivityOption(id: 'c', text: 'lstSayilar.Items.Append(i);'),
        ActivityOption(id: 'd', text: 'lstSayilar.Text = i.ToString();'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'ListBox\'a eleman eklemek için .Items.Add() metodu kullanılır. for döngüsü ile 1\'den 5\'e kadar her i değeri ListBox\'a eklenir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w11-a04': ActivityModel(
    id: 'gp-w11-a04',
    type: ActivityType.choice,
    title: 'Geri Sayım for Döngüsü (K7)',
    skill: 'loop_design',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          '10\'dan 1\'e kadar geri sayan bir for döngüsü için hangi başlık doğrudur?',
      options: [
        ActivityOption(id: 'a', text: 'for (int i = 10; i > 0; i++)'),
        ActivityOption(id: 'b', text: 'for (int i = 10; i >= 1; i--)'),
        ActivityOption(id: 'c', text: 'for (int i = 1; i <= 10; i--)'),
        ActivityOption(id: 'd', text: 'for (int i = 0; i < 10; i--)'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Geri saymak için başlangıç değeri 10, koşul i >= 1 ve adım i-- (azaltma) olmalıdır. i++ kullanılırsa sonsuz döngü oluşur.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w11-a05': ActivityModel(
    id: 'gp-w11-a05',
    type: ActivityType.choice,
    title: 'Ortalama Hesabı (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcı 5 sayı giriyor, bunların ortalamasını hesaplamak için hangi yaklaşım doğrudur?',
      options: [
        ActivityOption(id: 'a', text: 'double ortalama = toplam / 5; (toplam int ise)'),
        ActivityOption(id: 'b', text: 'double ortalama = (double)toplam / 5;'),
        ActivityOption(id: 'c', text: 'int ortalama = toplam / 5.0;'),
        ActivityOption(id: 'd', text: 'double ortalama = toplam * 0.5;'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'toplam int türündeyse toplam / 5 tam sayı bölmesi yapar. (double)toplam ile önce double\'a cast edilip bölünmesi, ondalıklı ortalama verir. Örn: toplam = 17, 17 / 5 = 3 (yanlış), (double)17 / 5 = 3.4 (doğru).',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 12 — while / do-while ve ComboBox
  // ══════════════════════════════════════════
  'gp-w12-a01': ActivityModel(
    id: 'gp-w12-a01',
    type: ActivityType.choice,
    title: 'while vs do-while Farkı (K2)',
    skill: 'loop_distinction',
    cognitiveLevel: 'understand',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'while döngüsü ile do-while döngüsü arasındaki en temel fark nedir?',
      options: [
        ActivityOption(id: 'a', text: 'while sadece sayısal koşullar için, do-while her tür için çalışır'),
        ActivityOption(id: 'b', text: 'do-while gövdesi en az bir kez çalışır; while koşul baştan false ise hiç çalışmayabilir'),
        ActivityOption(id: 'c', text: 'while daha hızlıdır, do-while daha yavaştır'),
        ActivityOption(id: 'd', text: 'İkisi tamamen aynı şekilde çalışır'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'do-while: önce gövde çalışır, sonra koşul kontrol edilir → minimum 1 çalışma garantisi. while: önce koşul kontrol edilir, false ise gövde hiç çalışmaz.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w12-a02': ActivityModel(
    id: 'gp-w12-a02',
    type: ActivityType.choice,
    title: 'Sonsuz Döngü Tehlikesi (K4)',
    skill: 'error_detection',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki while döngüsü neden sonsuz döngüye girer?',
      codeSnippet: 'int sayac = 0;\nwhile (sayac < 5)\n{\n    lblSonuc.Text = sayac.ToString();\n}',
      options: [
        ActivityOption(id: 'a', text: 'Koşul yanlış yazılmış (sayac > 5 olmalıydı)'),
        ActivityOption(id: 'b', text: 'sayac değişkeni döngü içinde artırılmıyor; koşul hiç false olmaz'),
        ActivityOption(id: 'c', text: 'while döngüleri C#\'ta bu şekilde yazılamaz'),
        ActivityOption(id: 'd', text: 'lblSonuc.Text atama işlemi döngüyü engeller'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'sayac döngü içinde artırılmıyor (sayac++ eksik). Bu durumda sayac = 0 hep true kalır ve program çöker. Çözüm: döngü gövdesine sayac++; eklemek.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w12-a03': ActivityModel(
    id: 'gp-w12-a03',
    type: ActivityType.choice,
    title: 'ComboBox Seçimi Okuma (K8)',
    skill: 'api_usage',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Kullanıcının ComboBox\'ta seçtiği öğeyi string olarak okumak için doğru kod hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'cmbRenk.Text'),
        ActivityOption(id: 'b', text: 'cmbRenk.SelectedItem.ToString()'),
        ActivityOption(id: 'c', text: 'cmbRenk.Value'),
        ActivityOption(id: 'd', text: 'Hem A hem B doğrudur'),
      ],
      correctOptionIds: ['d'],
      explanation:
          'ComboBox\'ta seçili öğeyi okumak için hem .Text hem de .SelectedItem.ToString() kullanılabilir. SelectedItem null olabilir; güvenli kullanım için null kontrolü önerilir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w12-a04': ActivityModel(
    id: 'gp-w12-a04',
    type: ActivityType.choice,
    title: 'do-while Hangi Durum (K7)',
    skill: 'loop_selection',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Hangi durum için do-while döngüsü daha uygun bir seçimdir?',
      options: [
        ActivityOption(id: 'a', text: 'Belirli sayıda (örn. 10 kez) tekrar yapılacak işlemler'),
        ActivityOption(id: 'b', text: 'Kullanıcıdan geçerli bir giriş alana kadar sormaya devam etmek (ilk soru mutlaka sorulmalı)'),
        ActivityOption(id: 'c', text: 'Bir liste üzerinde dolaşmak'),
        ActivityOption(id: 'd', text: 'Hiçbir zaman çalışmayabilecek isteğe bağlı işlemler'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Kullanıcıya "geçerli değer girin" diyerek en az bir kez soru sormak istiyorsanız do-while idealdir. Gövde çalışır, koşul kontrol edilir, geçersizse tekrar sorulur.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w12-a05': ActivityModel(
    id: 'gp-w12-a05',
    type: ActivityType.choice,
    title: 'break ile Döngüden Çıkış (K3)',
    skill: 'output_prediction',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt: 'Aşağıdaki döngü kaç kez çalışır?',
      codeSnippet:
          'int i = 0;\nwhile (true)\n{\n    i++;\n    if (i == 3) break;\n}',
      options: [
        ActivityOption(id: 'a', text: 'Sonsuz kez'),
        ActivityOption(id: 'b', text: '2 kez'),
        ActivityOption(id: 'c', text: '3 kez'),
        ActivityOption(id: 'd', text: '4 kez'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'i = 1, 2, 3 → i == 3 olunca break çalışır ve döngüden çıkılır. Toplam 3 iterasyon. while(true) sonsuz döngü başlatır ama break ile istenen noktada çıkılabilir.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 13 — Diziler ve Random
  // ══════════════════════════════════════════
  'gp-w13-a01': ActivityModel(
    id: 'gp-w13-a01',
    type: ActivityType.choice,
    title: 'Dizi İndeksleme (K3)',
    skill: 'array_indexing',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki kodda sayilar[3] hangi değeri döndürür?',
      codeSnippet: 'int[] sayilar = { 10, 20, 30, 40, 50 };',
      options: [
        ActivityOption(id: 'a', text: '30'),
        ActivityOption(id: 'b', text: '40'),
        ActivityOption(id: 'c', text: '50'),
        ActivityOption(id: 'd', text: 'IndexOutOfRangeException'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Dizi indeksleri 0\'dan başlar: sayilar[0]=10, [1]=20, [2]=30, [3]=40, [4]=50. sayilar[3] = 40.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w13-a02': ActivityModel(
    id: 'gp-w13-a02',
    type: ActivityType.choice,
    title: 'IndexOutOfRange Hatası (K4)',
    skill: 'error_detection',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 20,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki kod çalıştığında ne olur?',
      codeSnippet: 'int[] sayilar = new int[3];\nlblSonuc.Text = sayilar[3].ToString();',
      options: [
        ActivityOption(id: 'a', text: '0 gösterir (varsayılan int değeri)'),
        ActivityOption(id: 'b', text: 'IndexOutOfRangeException hatası fırlatır'),
        ActivityOption(id: 'c', text: 'Derleme hatası verir'),
        ActivityOption(id: 'd', text: 'Boş string gösterir'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'new int[3] → 3 elemanlı dizi: sayilar[0], [1], [2]. sayilar[3] geçersiz indeks; çalışma zamanında IndexOutOfRangeException fırlatır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w13-a03': ActivityModel(
    id: 'gp-w13-a03',
    type: ActivityType.choice,
    title: 'Random Sayı Üretimi (K1)',
    skill: 'api_knowledge',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          '1 ile 6 arasında (uçlar dahil) rastgele tam sayı üretmek için doğru kod hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'Random.Next(1, 6)'),
        ActivityOption(id: 'b', text: 'new Random().Next(1, 7)'),
        ActivityOption(id: 'c', text: 'Random.Range(1, 6)'),
        ActivityOption(id: 'd', text: 'Math.Random(1, 6)'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Random.Next(min, max) → min dahil, max hariç. 1 ile 6 arası dahil için Next(1, 7) kullanılmalıdır. Random sınıfı önce örneklenmelidir: Random rnd = new Random(); rnd.Next(1, 7);',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w13-a04': ActivityModel(
    id: 'gp-w13-a04',
    type: ActivityType.choice,
    title: 'Dizi Tanımlama Yolları (K2)',
    skill: 'syntax_knowledge',
    cognitiveLevel: 'understand',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Aşağıdaki iki dizi tanımlama yöntemi arasındaki fark nedir?',
      codeSnippet:
          '// Yol A:\nint[] a = new int[3];\n\n// Yol B:\nint[] b = { 10, 20, 30 };',
      options: [
        ActivityOption(id: 'a', text: 'İkisi tamamen aynıdır'),
        ActivityOption(id: 'b', text: 'Yol A: boş 3 elemanlı dizi (varsayılan 0); Yol B: elemanlarla birlikte başlatılmış 3 elemanlı dizi'),
        ActivityOption(id: 'c', text: 'Yol A yalnızca double için, Yol B yalnızca int için kullanılır'),
        ActivityOption(id: 'd', text: 'Yol B derleme hatası verir'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'new int[3] → tüm elemanlar 0 olarak başlar. { 10, 20, 30 } → başlangıç değerleriyle tanımlama. İkisi de int[3] boyutunda dizi oluşturur ama Yol A değerleri sonradan atanmalıdır.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w13-a05': ActivityModel(
    id: 'gp-w13-a05',
    type: ActivityType.choice,
    title: 'Dizi Döngüsü (K5)',
    skill: 'scenario',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'Bir dizideki en büyük değeri bulmak için hangi yaklaşım doğrudur?',
      options: [
        ActivityOption(id: 'a', text: 'max = dizi[0];\nfor her i: max = dizi[i]; — her adımda max\'ı dizi[i] ile değiştir'),
        ActivityOption(id: 'b', text: 'max = 0;\nfor her i: if (dizi[i] > max) max = dizi[i];'),
        ActivityOption(id: 'c', text: 'max = dizi[0];\nfor her i: if (dizi[i] > max) max = dizi[i];'),
        ActivityOption(id: 'd', text: 'Dizinin son elemanı her zaman en büyüktür'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'İlk eleman varsayılan max alınır (0 değil, çünkü negatif sayılar olabilir). Sonra her eleman karşılaştırılır; büyükse max güncellenir.',
    ),
    settings: ActivitySettings(),
  ),

  // ══════════════════════════════════════════
  // HAFTA 14 — Final: Not Kayıt Sistemi
  // ══════════════════════════════════════════
  'gp-w14-a01': ActivityModel(
    id: 'gp-w14-a01',
    type: ActivityType.choice,
    title: 'Bütünleşik Proje Senaryosu (K5)',
    skill: 'scenario',
    cognitiveLevel: 'evaluate',
    difficulty: 3,
    xp: 25,
    content: ChoiceActivityContent(
      prompt:
          '10 öğrencinin notunu saklayan ve ortalamasını bulan program için en uygun veri yapısı nedir?',
      options: [
        ActivityOption(id: 'a', text: '10 ayrı double değişkeni (not1, not2, ... not10)'),
        ActivityOption(id: 'b', text: 'double türünde 10 elemanlı tek bir dizi + for döngüsü'),
        ActivityOption(id: 'c', text: 'Yalnızca 1 değişken ve döngüde üzerine yazma'),
        ActivityOption(id: 'd', text: 'string değişkeni içinde virgülle ayrılmış değerler'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Dizi + döngü kombinasyonu hem belleği verimli kullanır hem de kod tekrarını önler. 10 ayrı değişken yönetmek zorlaştırır ve ölçeklenemez.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w14-a02': ActivityModel(
    id: 'gp-w14-a02',
    type: ActivityType.choice,
    title: 'Min-Max Bulma Algoritması (K6)',
    skill: 'algorithm_order',
    cognitiveLevel: 'analyze',
    difficulty: 3,
    xp: 25,
    content: ChoiceActivityContent(
      prompt:
          'Bir dizide minimum değeri bulan algoritmanın doğru adım sırası hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'Döngüyü çalıştır → min başlangıç değerini ata → Karşılaştırma yap'),
        ActivityOption(id: 'b', text: 'min = dizi[0] ata → Döngü ile her elemanı karşılaştır → min\'i küçük olanla güncelle → Sonucu göster'),
        ActivityOption(id: 'c', text: 'min = 0 ata → Döngü çalıştır → Karşılaştırma yap'),
        ActivityOption(id: 'd', text: 'Diziyi sırala → ilk elemanı al'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Doğru sıra: (1) min = dizi[0] (ilk eleman, 0 değil), (2) for döngüsü ile her eleman gezilir, (3) dizi[i] < min ise min = dizi[i], (4) döngü biter, min gösterilir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w14-a03': ActivityModel(
    id: 'gp-w14-a03',
    type: ActivityType.choice,
    title: 'ListBox Temizleme (K7)',
    skill: 'api_usage',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: ChoiceActivityContent(
      prompt:
          'ListBox içindeki tüm öğeleri silmek için hangi kod doğrudur?',
      options: [
        ActivityOption(id: 'a', text: 'lstOgrenciler.Clear()'),
        ActivityOption(id: 'b', text: 'lstOgrenciler.Text = ""'),
        ActivityOption(id: 'c', text: 'lstOgrenciler.Items.Clear()'),
        ActivityOption(id: 'd', text: 'lstOgrenciler.Remove()'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'ListBox öğeleri Items koleksiyonunda tutulur; temizlemek için .Items.Clear() kullanılır. .Clear() doğrudan ListBox üzerinde çağrılamaz.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w14-a04': ActivityModel(
    id: 'gp-w14-a04',
    type: ActivityType.choice,
    title: 'Entegre Hata Yönetimi (K5)',
    skill: 'scenario',
    cognitiveLevel: 'evaluate',
    difficulty: 3,
    xp: 25,
    content: ChoiceActivityContent(
      prompt:
          'Not giriş ekranında bir öğrenci notu boş bırakıp "Ekle" butonuna basarsa en iyi kullanıcı deneyimini sunan yaklaşım hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'Programı çökerterek kullanıcıyı uyarmak'),
        ActivityOption(id: 'b', text: 'Boş değeri 0 kabul edip diziye eklemek'),
        ActivityOption(id: 'c', text: 'TextBox boşsa MessageBox.Show ile uyarı vermek, işlemi iptal etmek ve odağı TextBox\'a vermek'),
        ActivityOption(id: 'd', text: 'Boş girilince otomatik -1 atamak'),
      ],
      correctOptionIds: ['c'],
      explanation:
          'İyi UX: kullanıcıya açıklayıcı mesaj (ne yanlış?) + odak (nereyi düzeltecek?) + iptal (bozuk veri sisteme girmez). 0 veya -1 atamak sessiz hata üretir.',
    ),
    settings: ActivitySettings(),
  ),

  'gp-w14-a05': ActivityModel(
    id: 'gp-w14-a05',
    type: ActivityType.project,
    title: 'Dönem Sonu C# Windows Forms Proje Teslimi',
    skill: 'project_submission',
    cognitiveLevel: 'create',
    difficulty: 3,
    xp: 50,
    content: ChoiceActivityContent(
      prompt:
          'Dönem boyunca öğrendiğiniz C# Windows Forms, Event Handler, Kontroller ve Dizi yapılarını kullanarak kendi bilgisayarınızda geliştirdiğiniz final uygulamasının GitHub repository bağlantısını teslim edin.',
      options: [],
      correctOptionIds: [],
    ),
    settings: ActivitySettings(),
  ),
};
