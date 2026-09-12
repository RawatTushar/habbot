import os
import sys

sys.path.insert(
    0,
    os.path.abspath(
        os.path.join(os.path.dirname(__file__), "..")
    ),
)

from django.conf import settings

if not settings.configured:
    settings.configure(
        USE_I18N=False,
    )

from student_api.serializers import StudentOnboardingSerializer


def test_case(name, data):
    serializer = StudentOnboardingSerializer(data=data)

    print(f"\n{name}")
    print("Valid:", serializer.is_valid())

    if serializer.errors:
        print("Errors:", serializer.errors)


base_data = {
    "student_id": "STU-10001",
    "student_name": "Aarav Sharma",
    "email": "aarav@example.com",
    "region": "North",
    "has_learning_difficulty": True,
}


test_case(
    "Student ID - 50 characters",
    {
        **base_data,
        "student_id": "A" * 50,
    },
)

test_case(
    "Student ID - 51 characters",
    {
        **base_data,
        "student_id": "A" * 51,
    },
)

test_case(
    "Student name - 200 characters",
    {
        **base_data,
        "student_name": "A" * 200,
    },
)

test_case(
    "Student name - 201 characters",
    {
        **base_data,
        "student_name": "A" * 201,
    },
)

test_case(
    "DCYN - invalid string value",
    {
        **base_data,
        "has_learning_difficulty": "yes",
    },
)

test_case(
    "Region - invalid value",
    {
        **base_data,
        "region": "Central",
    },
)