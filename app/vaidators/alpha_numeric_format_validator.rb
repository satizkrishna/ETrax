class AlphaNumericFormatValidator < ActiveModel::EachValidator
  def validate_each(record, field, value)
    unless value.blank?
      record.errors[field] << "should only have alphanumeric (letters/numbers/underscores) characters" unless value =~ /^[[:alnum:]._-]+$/
      record.errors[field] << "contains non-permitted characters" unless value.ascii_only?
    end
  end
end