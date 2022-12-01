## 3.0.0

> Note: This release has breaking changes.

 - **FIX**: provide type argument to js_util `getProperty`.
 - **FEAT**: add `ConsentInfo.purposeConsents|purposeLegitimateInterests`.
 - **FEAT**: expose `raw` consent info from CMP SDK in `BasicConsentInfo`.
 - **BREAKING** **FEAT**: rename `ConsentInfo.publisherConsent` to `publisherConsents`.

## 2.0.0

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: add `BasicConsentInfo` for when full `ConsentInfo` is not avilable.

## 1.2.2

 - **STYLE**: update analysis options.
 - **FIX**: local dependencies.
 - **CI**: setup.
 - **CHORE**: publish packages.

## 1.2.1

 - **FIX**: revert to sdk constraint `>=2.12.0-0 <3.0.0`.

## 1.2.0

 - **FIX**: use `late` without unnecessary wrapper.
 - **FEAT**: migrate to nullsafety.
 - **FEAT**: bump dependencies.
 - **CHORE**: publish packages.

## 1.1.0

 - **FIX**: use `late` without unnecessary wrapper.
 - **FEAT**: migrate to nullsafety.
 - **FEAT**: bump dependencies.

## 1.0.0 - 2020-12-29

- Initial release
