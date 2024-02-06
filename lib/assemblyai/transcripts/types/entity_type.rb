# frozen_string_literal: true

module AssemblyAI
  class Transcripts
    # @type [ENTITY_TYPE]
    ENTITY_TYPE = {
      banking_information: "banking_information",
      blood_type: "blood_type",
      credit_card_cvv: "credit_card_cvv",
      credit_card_expiration: "credit_card_expiration",
      credit_card_number: "credit_card_number",
      date: "date",
      date_of_birth: "date_of_birth",
      drivers_license: "drivers_license",
      drug: "drug",
      email_address: "email_address",
      event: "event",
      injury: "injury",
      language: "language",
      location: "location",
      medical_condition: "medical_condition",
      medical_process: "medical_process",
      money_amount: "money_amount",
      nationality: "nationality",
      occupation: "occupation",
      organization: "organization",
      password: "password",
      person_age: "person_age",
      person_name: "person_name",
      phone_number: "phone_number",
      political_affiliation: "political_affiliation",
      religion: "religion",
      time: "time",
      url: "url",
      us_social_security_number: "us_social_security_number"
    }.freeze
  end
end
