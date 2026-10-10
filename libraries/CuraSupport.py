"""Small custom Python keyword library for framework-level helpers."""
from robot.api.deco import keyword, library
from datetime import datetime


@library(scope="GLOBAL", auto_keywords=False)
class CuraSupport:
    """Framework utilities that are independent of Selenium."""

    @keyword("Create Unique Appointment Comment")
    def create_unique_appointment_comment(self, prefix="Robot Framework appointment"):
        stamp = datetime.now().strftime("%Y%m%d-%H%M%S")
        return f"{prefix} {stamp}"
