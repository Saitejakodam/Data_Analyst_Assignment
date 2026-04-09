def convert_minutes(minutes):
    hours = minutes // 60
    remaining_minutes = minutes % 60

    result = ""

    if hours > 0:
        if hours == 1:
            result += f"{hours} hr "
        else:
            result += f"{hours} hrs "

    if remaining_minutes > 0:
        result += f"{remaining_minutes} minutes"

    return result.strip()
minutes = int(input("Enter number of minutes: "))
output = convert_minutes(minutes)
print(output)
