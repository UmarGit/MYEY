# Myey [![Myey's Completion Progress - 44%](https://img.shields.io/static/v1?label=Myey's+Completion+Progress&message=44%&color=brightgreen&logo=flutter&logoColor=blue)](https://github.com/UmarGit/MYEY) [![Myey Flutter Release Apk](https://github.com/UmarGit/MYEY/actions/workflows/flutter-apk-release.yml/badge.svg)](https://github.com/UmarGit/MYEY/actions/workflows/flutter-apk-release.yml)

> Our solution is for healthy eyesight by identifying its weaknesses earlier.

> The problem I see is that in my surroundings people are very hesitant to visit the doctor to get their eyes tested but they delay the process so much which will slowly weaken their eyes more and more.

> We are working on a solution to test the eyes of individuals to give an estimate of their visual power and testing their eyes on the app rewards them. So they can redeem those points in clinics and hospitals for discounts.

## Getting Started

To run the project on **IOS**

```bash
flutter run ios
```

To run the project on **ANDROID**

```bash
flutter run android
```

## Deadlines ( Should be strictly followed )

| **Task** | **Deadline** | **Assigned To** |  **`Status`** |
| --- | --- | --- | --- |
| Information Gathering | 15th March | `Subhan Talal` | **100%** |
| Algorithm Development | 12th March 2022 | `Umar Ahmed & Subhan Ahmed` | **95%** |
| User Interface Design | 14th March 2022 | `Don't Know Yet` | **80%** |
| Testing & Pitch | 18th March 2022 | `Umer Waseem` | **95%** |

## Formula

A reference is needed to derive a metric value for the screen to face distance: the eye to eye distance at a specific screen to face distance. We call this the reference picture and reference distance. By comparing the eye to eye distance of an actual camera picture with values from the reference picture, we can calculate the actual screen to face distance. We describe the relation between the eye to eye distance and the screen to face distance in respect to a reference by the following equation:

    dsf = pref / psf * dref

> Where:
> - `dsf` is the **screen to face** distance
> - `psf` is the **eye to eye** distance on the **actual picture**.
> - `dref` is the **screen to face** distance of the **reference picture**
> - `pref` is the **eye to eye** distance on the **reference picture**.

> We assume a linear relation between the screen to face distance and the eye to eye distance. The experiment outlined in Section IV and V reinforces our linearity assumption in a range from **19cm** to **89cm** screen to face distance.

## Explanation ( What to achieve )

#### Get an idea of steps to be followed:

1. Take a picture with the front camera

2. Detect the face and eyes

3. Calculate the eye to eye distance

4. Use (1) and the reference picture values to calculate the screen to face distance

5. Average the screen to face distance over the last five measurements

```mermaid

sequenceDiagram

Picture -> FrontCamera: Take a picture with the front camera

Note left of Picture: Reference Picture

Face -> Eye: Detect the face and eyes

Eye -> Eye: Calculate the eye to eye distance

Screen -> Face: Use (1) and the reference picture values to calculate the screen to face distance

Screen -> Face: Average the screen to face distance over the last five measurements

```

# Reference

[GET RESEARCH PAPER HERE](https://github.com/UmarGit/MYEY/research_paper.pdf)
