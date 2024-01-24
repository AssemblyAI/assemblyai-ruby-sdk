# frozen_string_literal: true

module AssemblyAI
  module Transcripts
    # @type [Hash{String => String}]
    PII_POLICY = {
      medical_process: "medical_process",
      medical_condition: "medical_condition",
      blood_type: "blood_type",
      drug: "drug",
      injury: "injury",
      number_sequence: "number_sequence",
      email_address: "email_address",
      date_of_birth: "date_of_birth",
      phone_number: "phone_number",
      us_social_security_number: "us_social_security_number",
      credit_card_number: "credit_card_number",
      credit_card_expiration: "credit_card_expiration",
      credit_card_cvv: "credit_card_cvv",
      date: "date",
      nationality: "nationality",
      event: "event",
      language: "language",
      location: "location",
      money_amount: "money_amount",
      person_name: "person_name",
      person_age: "person_age",
      organization: "organization",
      political_affiliation: "political_affiliation",
      occupation: "occupation",
      religion: "religion",
      drivers_license: "drivers_license",
      banking_information: "banking_information"
    }.frozen
  end
end
