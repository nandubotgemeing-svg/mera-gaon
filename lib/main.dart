# MERA GAON — Version 1.0 Starter

यह Flutter का शुरुआती UI डेमो प्रोजेक्ट है।

## अभी क्या काम करता है?
- Green + White होम स्क्रीन
- नीचे Home, News, Market, Jobs और Profile टैब
- पोस्ट फॉर्म और इस ऐप के चलने के दौरान pending पोस्ट की गिनती
- बुनियादी हिंदी UI

## अभी क्या जुड़ा नहीं है?
यह अभी पूरा ऑनलाइन ऐप नहीं है। इसमें Supabase/Firebase backend, असली OTP, Google Sign-In, फोटो अपलोड, Admin dashboard, server-side moderation, push notifications और 22 भाषाओं का अनुवाद नहीं जुड़ा है। पोस्ट अभी किसी सर्वर पर नहीं जाती। असली यूजर डेटा या असली नौकरी/खबरें इसमें न डालें।

## कंप्यूटर से चलाने के निर्देश
1. Flutter SDK और Android Studio इंस्टॉल करें।
2. इस फोल्डर में टर्मिनल खोलें।
3. `flutter pub get`
4. Android फोन में Developer options और USB debugging चालू करें।
5. `flutter devices`
6. `flutter run`

## Android APK बनाना
`flutter build apk --release`
APK यहाँ बनेगी: `build/app/outputs/flutter-apk/app-release.apk`

## iPhone
इसी Flutter codebase को iOS के लिए भी इस्तेमाल किया जा सकता है, लेकिन iOS build/signing के लिए macOS और Xcode चाहिए।

## अगला विकास चरण
1. Supabase project बनाकर database और storage configure करें।
2. Phone OTP authentication जोड़ें।
3. Google Sign-In के Android/iOS OAuth credentials configure करें।
4. `posts` table में `pending/approved/rejected` status रखें।
5. केवल admin role को approval permission दें। Public app केवल `approved` posts पढ़े।
6. Storage policies, Row Level Security और spam/report controls लागू करें।
