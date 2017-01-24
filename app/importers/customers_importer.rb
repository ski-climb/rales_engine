require 'csv'

class CustomersImporter

  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Customers", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|

      customer_attributes = {
        id:         row['id'].to_i,
        first_name: row['first_name'],
        last_name:  row['last_name'],
        updated_at: to_date(row['updated_at']),
        created_at: to_date(row['created_at'])
      }

      Customer.create!(customer_attributes)

      bar.increment
    end
    bar.finish
  end

  private

    def to_date(string)
      DateTime.parse(string)
    end
end
