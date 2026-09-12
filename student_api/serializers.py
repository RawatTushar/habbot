from rest_framework import serializers


class StrictBooleanField(serializers.BooleanField):
    def to_internal_value(self, data):
        if not isinstance(data, bool):
            self.fail("invalid")

        return data


class StudentOnboardingSerializer(serializers.Serializer):
    student_id = serializers.CharField(
        required=True,
        allow_blank=False,
        max_length=50,
    )

    student_name = serializers.CharField(
        required=True,
        allow_blank=False,
        max_length=200,
    )

    email = serializers.EmailField(
        required=True,
        max_length=254,
    )

    region = serializers.ChoiceField(
        required=True,
        choices=["North", "South", "East", "West"],
    )

    has_learning_difficulty = StrictBooleanField(
        required=True,
    )

    def validate_student_id(self, value):
        value = value.strip()

        if not value:
            raise serializers.ValidationError(
                "Student identifier must contain at least one non-whitespace character."
            )

        return value

    def validate_student_name(self, value):
        value = value.strip()

        if not value:
            raise serializers.ValidationError(
                "Student name must contain at least one non-whitespace character."
            )

        return value