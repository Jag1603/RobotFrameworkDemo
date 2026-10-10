# CURA Healthcare — Robot Framework Automation Framework

An extensible, industry-style UI automation starter for the public CURA demo application:
https://katalon-demo-cura.herokuapp.com/

## Technology
- Python 3.11+
- Robot Framework
- SeleniumLibrary / Selenium WebDriver
- Environment-driven configuration
- Page Object-style keyword resources
- Smoke and regression suites
- Screenshots on failure, Robot log/report output
- GitHub Actions CI

> The CURA site is a public demo. Tests create demo appointments and should not be pointed at production systems.

## Project structure

```text
cura_robot_framework/
├── .github/workflows/robot-tests.yml
├── config/
│   └── environments.py
├── libraries/
│   └── CuraSupport.py
├── resources/
│   ├── common.resource
│   ├── pages/
│   │   ├── appointment_page.resource
│   │   ├── history_page.resource
│   │   └── login_page.resource
│   └── variables.resource
├── tests/
│   ├── regression/
│   │   └── appointment_tests.robot
│   └── smoke/
│       └── smoke_tests.robot
├── .gitignore
├── requirements.txt
└── robot.yaml
```

## 1. Install prerequisites

Install Python 3.11 or newer and a current Chrome or Edge browser.

```bash
python -m venv .venv
# Windows PowerShell
.\.venv\Scripts\Activate.ps1
# Windows cmd: .venv\Scripts\activate.bat
# macOS/Linux
source .venv/bin/activate

python -m pip install --upgrade pip
pip install -r requirements.txt
```

Selenium Manager normally resolves the matching browser driver automatically. If your corporate environment blocks driver downloads, install a compatible driver and make it available on `PATH`.

## 2. Run tests

Run all tests:
```bash
robot --outputdir results tests
```

Smoke suite:
```bash
robot --outputdir results tests/smoke
```

Regression suite:
```bash
robot --outputdir results tests/regression
```

Run headless:
```bash
robot --variable HEADLESS:true --outputdir results tests
```

Choose an environment:
```bash
robot --variable ENV:qa --outputdir results tests
```

Override the base URL:
```bash
robot --variable BASE_URL:https://katalon-demo-cura.herokuapp.com/ --outputdir results tests
```

On completion, open `results/report.html` and `results/log.html`.

## 3. Configuration

`config/environments.py` holds named environment URLs. You can override the URL with Robot's `BASE_URL` variable. `HEADLESS` is `false` by default; use `--variable HEADLESS:true` in CI. Do not put passwords or tokens in source control; use CI secrets or environment variables for sensitive values.

## 4. Design principles

- **Readable tests:** scenarios use business-level keywords rather than raw Selenium calls.
- **Page/resource separation:** page actions and locators live under `resources/pages`.
- **Central configuration:** URL, browser, timeout and headless mode are configurable.
- **Failure diagnostics:** browser screenshots are captured by SeleniumLibrary's listener on test failure; Robot also records keyword and browser logs.
- **CI-ready:** GitHub Actions installs dependencies and publishes reports even if tests fail.
- **Maintainable locators:** prefer stable IDs and accessible labels; keep locators centralized.
- **Isolation:** each test opens a fresh browser session.

## 5. Included scenarios

- Smoke: home page loads; appointment entry point opens login.
- Regression: login, make an appointment, verify confirmation; history page access.
- Invalid login validation.

The public demo can change or occasionally be unavailable. If a test fails because the site's markup or behavior changes, inspect `results/log.html` and update the centralized locator in the corresponding resource.

## 6. Extending for a real project

Suggested next additions:
1. Add API checks with `robotframework-requests`.
2. Add test data from JSON/CSV and a data-driven template.
3. Add a secrets provider for credentials.
4. Add parallel execution using Pabot after checking the demo site can tolerate concurrency.
5. Add Allure with `robotframework-allure` if your reporting standard requires it.
6. Add environment-specific test tags and scheduled/nightly workflows.
7. Add accessibility, visual, database, and contract checks as separate layers.

## Troubleshooting

- **Browser does not launch:** verify Chrome/Edge is installed and Selenium Manager can access driver downloads.
- **PowerShell blocks activation:** use `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` for the current shell, or activate through cmd.
- **Tests are flaky:** avoid parallel runs against this shared public demo; use explicit waits and keep test data unique.
- **No report appears:** Robot writes reports to `results/` when the command includes `--outputdir results`.
