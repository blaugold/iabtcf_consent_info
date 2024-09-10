## 3.4.0

 - **FEAT**: set JVM target to 1.8.

## 3.3.0

 - **FEAT**: upgrade kotlin to `1.8.22` (#25).

## 3.2.0

 - **FEAT**: moderize Android project (#24).

## 3.1.0

 - **FEAT**: add purpose 11: Use limited data to select content (#12).

## 3.0.0

> Note: This release has breaking changes.

 - **FEAT**: add `ConsentInfo.purposeConsents|purposeLegitimateInterests`.
 - **FEAT**: expose `raw` consent info from CMP SDK in `BasicConsentInfo`.
 - **BREAKING** **FEAT**: rename `ConsentInfo.publisherConsent` to `publisherConsents`.

## 2.0.0

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: add `BasicConsentInfo` for when full `ConsentInfo` is not avilable.

## 1.3.3

 - **FIX**: propagate errors and handle loading CMP.
 - **FIX**: prefix error string in example app.
 - **CI**: setup.

## 1.3.2

 - **REFACTOR**: ignore `close_sinks` lint for `ReplaySubject`.

## 1.3.1

 - **FIX**: revert to sdk constraint `>=2.12.0-0 <3.0.0`.

## 1.3.0

 - **FIX**: use `late` without unnecessary wrapper.
 - **FEAT**: bump dependencies.
 - **DOCS**: fix typo.
 - **CHORE**: publish packages.

## 1.2.0

 - **FIX**: use `late` without unnecessary wrapper.
 - **FEAT**: bump dependencies.

# [1.1.0] - 2020-12-29

- **feat**: endorse web implementation
- **fix**: add missing separators in `ConsentInfo.toString`

# [1.0.0] - 2020-12-24

- Initial release
