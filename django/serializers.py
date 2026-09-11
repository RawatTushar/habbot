from rest_framework import serializers


class StudentOnboardingSerializer(serializers.Serializer):
    full_name = serializers.CharField(max_length=200)
    email = serializers.EmailField()