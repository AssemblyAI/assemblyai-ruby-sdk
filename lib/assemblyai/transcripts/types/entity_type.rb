# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # The type of entity for the detected entity
    class EntityType
      BANKING_INFORMATION = "banking_information"
      BLOOD_TYPE = "blood_type"
      CREDIT_CARD_CVV = "credit_card_cvv"
      CREDIT_CARD_EXPIRATION = "credit_card_expiration"
      CREDIT_CARD_NUMBER = "credit_card_number"
      DATE = "date"
      DATE_OF_BIRTH = "date_of_birth"
      DRIVERS_LICENSE = "drivers_license"
      DRUG = "drug"
      EMAIL_ADDRESS = "email_address"
      EVENT = "event"
      INJURY = "injury"
      LANGUAGE = "language"
      LOCATION = "location"
      MEDICAL_CONDITION = "medical_condition"
      MEDICAL_PROCESS = "medical_process"
      MONEY_AMOUNT = "money_amount"
      NATIONALITY = "nationality"
      OCCUPATION = "occupation"
      ORGANIZATION = "organization"
      PASSWORD = "password"
      PERSON_AGE = "person_age"
      PERSON_NAME = "person_name"
      PHONE_NUMBER = "phone_number"
      POLITICAL_AFFILIATION = "political_affiliation"
      RELIGION = "religion"
      TIME = "time"
      URL = "url"
      US_SOCIAL_SECURITY_NUMBER = "us_social_security_number"
    end
  end
end
