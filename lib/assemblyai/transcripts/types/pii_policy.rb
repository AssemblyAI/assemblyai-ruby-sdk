# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # The type of PII to redact
    class PiiPolicy
      ACCOUNT_NUMBER = "account_number"
      BANKING_INFORMATION = "banking_information"
      BLOOD_TYPE = "blood_type"
      CREDIT_CARD_CVV = "credit_card_cvv"
      CREDIT_CARD_EXPIRATION = "credit_card_expiration"
      CREDIT_CARD_NUMBER = "credit_card_number"
      DATE = "date"
      DATE_INTERVAL = "date_interval"
      DATE_OF_BIRTH = "date_of_birth"
      DRIVERS_LICENSE = "drivers_license"
      DRUG = "drug"
      DURATION = "duration"
      EMAIL_ADDRESS = "email_address"
      EVENT = "event"
      FILENAME = "filename"
      GENDER_SEXUALITY = "gender_sexuality"
      HEALTHCARE_NUMBER = "healthcare_number"
      INJURY = "injury"
      IP_ADDRESS = "ip_address"
      LANGUAGE = "language"
      LOCATION = "location"
      MARITAL_STATUS = "marital_status"
      MEDICAL_CONDITION = "medical_condition"
      MEDICAL_PROCESS = "medical_process"
      MONEY_AMOUNT = "money_amount"
      NATIONALITY = "nationality"
      NUMBER_SEQUENCE = "number_sequence"
      OCCUPATION = "occupation"
      ORGANIZATION = "organization"
      PASSPORT_NUMBER = "passport_number"
      PASSWORD = "password"
      PERSON_AGE = "person_age"
      PERSON_NAME = "person_name"
      PHONE_NUMBER = "phone_number"
      PHYSICAL_ATTRIBUTE = "physical_attribute"
      POLITICAL_AFFILIATION = "political_affiliation"
      RELIGION = "religion"
      STATISTICS = "statistics"
      TIME = "time"
      URL = "url"
      US_SOCIAL_SECURITY_NUMBER = "us_social_security_number"
      USERNAME = "username"
      VEHICLE_ID = "vehicle_id"
      ZODIAC_SIGN = "zodiac_sign"
    end
  end
end
