import '../domain/models/activity_models.dart';
import 'gp_activities.dart';
import 'mm_activities.dart';
import 'ntp_activities.dart';
import 'siber_activities.dart';
import 'syz_activities.dart';
import 'vm_activities.dart';

final Map<String, ActivityModel> mockActivities = {
  // Test Course - Week 1: Choice Activity
  'test-w01-a01': const ActivityModel(
    id: 'test-w01-a01',
    type: ActivityType.choice,
    title: '1. Çoktan Seçmeli (Choice) Testi',
    skill: 'concept_recognition',
    cognitiveLevel: 'remember',
    difficulty: 1,
    xp: 10,
    content: ChoiceActivityContent(
      prompt:
          'Visual Studio arayüzünde bir kontrolün kod içerisindeki benzersiz kimliğini belirten özellik hangisidir?',
      options: [
        ActivityOption(id: 'a', text: 'Text'),
        ActivityOption(id: 'b', text: 'Name'),
        ActivityOption(id: 'c', text: 'Tag'),
        ActivityOption(id: 'd', text: 'Font'),
      ],
      correctOptionIds: ['b'],
      explanation:
          'Name özelliği, kontrolün C# kod bloğu içerisindeki değişken kimliğidir. Text ise kullanıcıya görünen yazıdır.',
      feedback: {
        'correct': 'Tebrikler! Kontrolün koddaki kimliği Name özelliğidir.',
        'incorrect': 'Name ile Text özelliklerini tekrar karşılaştırınız.',
      },
    ),
    settings: ActivitySettings(
      allowRetry: true,
      maxAttempts: 2,
      revealAnswerAfterMaxAttempts: true,
      showExplanationAfterSubmit: true,
    ),
  ),

  // Test Course - Week 1: Matching Activity
  'test-w01-a02': const ActivityModel(
    id: 'test-w01-a02',
    type: ActivityType.matching,
    title: '2. Eşleştirme (Matching) Testi',
    skill: 'term_definition_matching',
    cognitiveLevel: 'understand',
    difficulty: 2,
    xp: 15,
    content: MatchingActivityContent(
      prompt:
          'Sol sütundaki terimleri sağ sütundaki doğru açıklamalarla eşleştiriniz.',
      pairs: [
        MatchingPair(
            leftId: 'l1',
            leftText: 'Button',
            rightId: 'r1',
            rightText: 'Tıklama olayı alan ve tetikleyici kontrol'),
        MatchingPair(
            leftId: 'l2',
            leftText: 'Label',
            rightId: 'r2',
            rightText: 'Kullanıcıya bilgi ve etiket gösteren kontrol'),
        MatchingPair(
            leftId: 'l3',
            leftText: 'TextBox',
            rightId: 'r3',
            rightText: 'Kullanıcıdan metin girdisi alan kontrol'),
      ],
      explanation:
          'Windows Forms kontrollerinin temel görevleri bu şekilde eşleşir.',
    ),
    settings: ActivitySettings(
      allowRetry: true,
      maxAttempts: 2,
    ),
  ),

  // Test Course - Week 2: Ordering Activity
  'test-w02-a01': const ActivityModel(
    id: 'test-w02-a01',
    type: ActivityType.ordering,
    title: '3. Sıralama (Ordering) Testi',
    skill: 'workflow_sequencing',
    cognitiveLevel: 'apply',
    difficulty: 2,
    xp: 15,
    content: OrderingActivityContent(
      prompt:
          'Yeni bir Windows Forms projesi oluşturup çalıştırma adımlarını doğru sıraya koyunuz.',
      items: [
        OrderingItem(id: 'step1', text: 'Visual Studio uygulamasını açın'),
        OrderingItem(id: 'step2', text: 'Create a new project şablonunu seçin'),
        OrderingItem(
            id: 'step3',
            text: 'Windows Forms App (.NET) şablonunu belirleyin'),
        OrderingItem(
            id: 'step4',
            text: 'Form üzerine bir Button sürükleyip F5 ile çalıştırın'),
      ],
      correctOrder: ['step1', 'step2', 'step3', 'step4'],
      explanation:
          'Doğru geliştirme akışı ortam açılışından proje oluşturma ve çalıştırmaya doğru ilerler.',
    ),
    settings: ActivitySettings(
      allowRetry: true,
      maxAttempts: 2,
    ),
  ),

  // Test Course - Week 2: Short Answer Activity
  'test-w02-a02': const ActivityModel(
    id: 'test-w02-a02',
    type: ActivityType.shortAnswer,
    title: '4. Kısa Cevap (Short Answer) Testi',
    skill: 'concept_explanation',
    cognitiveLevel: 'understand',
    difficulty: 2,
    xp: 15,
    content: ShortAnswerActivityContent(
      prompt: 'Olay Güdümlü Programlama (OGP) nedir? Kısaca açıklayınız.',
      keywords: ['olay', 'event', 'reaktif', 'tetikleyici', 'pasif'],
      sampleAnswer:
          'Programın kullanıcı veya sistem olaylarını pasif bekleme durumunda kalıp tetikleyicilerle çalışmasıdır.',
      explanation:
          'OGP, sistemin pasif bekleyip olay gerçekleştiğinde tetiklenmesini ifade eder.',
    ),
    settings: ActivitySettings(
      allowRetry: true,
      maxAttempts: 2,
    ),
  ),

  // Add course activities:
  ...gpActivities,
  ...ntpActivities,
  ...siberActivities,
  ...vmActivities,
  ...mmActivities,
  ...syzActivities,
};
