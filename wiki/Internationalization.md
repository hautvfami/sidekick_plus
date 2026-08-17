# Internationalization

# Adding a Language

## Add a new Language

Before letting Sidekick+ know that there's a new language in the app, translate the existing files into your target language.

For this you'll find a folder named `localizations` in the root folder of Sidekick+:

```
localizations/
├── en-US/
│   ├── components.json
│   ├── modules.json
│   └── settings.json
├── es-ES/
├── ja-JP/
└── ...
```

The JSON files above contain the actual texts, each with a corresponding key (or piece of the app). Sidekick+ only uses the keys to identify a translation. The actual translation can be a simple String or a more complex structure.

To start, copy any of the folders and change the folder name to the desired language. If you're not sure, check the language [code here](https://docs.oracle.com/cd/E13214_01/wli/docs92/xref/xqisocodes.html). To construct a folder name, first pick a code from the `ISO-639 Language Codes List`, followed by a `-` and then a country code from the `ISO-3166 Country Codes List`. For example, `es` for Spanish and `MX` for Mexico, so the folder name would be `es-MX`.

Once that's done, start going through the files and changing the values for the JSON. You may encounter different types of key-value pairs.

### Simple Strings

These are the easiest to handle — just a static string that can be translated directly.

For example:

```json
{
  "refresh": "Actualizar"
}
```

The key is then used in the code to place the translation into the UI:

```dart
context.i18n('components:refresh')
```

### Nested values

You may also find nested translations, such as:

```json
{
  "atoms": {
    "refresh": "Actualizar"
  }
}
```

Which is similarly called in code in the following way:

```dart
context.i18n('components:atoms.refresh')
```

### Variables in translations

You can also encounter variables inside the translations. For example:

```json
{
  "atoms": {
    "countFound": "{{count}} encontrado(s)"
  }
}
```

Make sure the variable, which is between the curly braces `{{varName}}`, is still part of the value after translation, but place it wherever it fits.

This can be called in the following way:

```dart
context.i18n(
  'components:atoms.countFound',
  variables: {'count': count.toString()},
),
```

### In Summary

You can specify the way translations will be called in the actual source code through the file name. For example, in `components.json`, the name of the file (`components`) is also the **namespace** for the translation. After that a `:` follows to tell the i18n package that it can go and find the first root key in that namespace. In the example above, `atoms` is one of the root keys. Then with every `.` you can specify the nested key inside `atoms`. You can structure and nest as deep as your app needs, but try to keep it as simple as possible, please.

## Adding a language into Flutter

The hard part's done. Now let's let Sidekick+ know about the new language.

### Adding the new assets

Firstly, you need to tell Flutter where to find the new folder of your translation. For that, just add a new asset entry in the `pubspec.yaml`, inside the `flutter` section, like this:

```yaml
flutter:
  assets:
    - localizations/en-US/
    - localizations/es-ES/
```

### Adding language to the language manager

Next, you only need to add a new `Locale` to the Language Manager, which you can find in `lib > i18n > language_manager.dart`.

### Adding the localized name to the rest of the languages

You're nearly done! Now, we need to show the user the proper language name in its native language, so don't forget to add an entry to the `settings.json` translation file:

```json
{
  "settings": {
    "languages": {
      "es-ES": "Español"
    }
  }
}
```

**Note: You need to add your language entry (for example: `"es-ES": "Español"`) to ALL existing `settings.json` files!**

That's it! That's all you need to do to add a new translation. Flutter will now automatically detect and read the new language and provide it in the `DropdownMenu`. Congrats!