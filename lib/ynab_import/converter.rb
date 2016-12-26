require "csv"
require "fileutils"
require "terminal-table"

module YnabImport
  class Converter
    def initialize(input_path, rewriter)
      @input_path = input_path
      @rewriter = rewriter
    end

    def convert!
      rewrite_csv
      print_preview
      # remove_input_file
    rescue Errno::ENOENT
      puts "Couldn't find file #{input_path}"
    end

    private

      attr_reader :input_path, :rewriter

      def rewrite_csv
        file = File.readlines(input_path, encoding: rewriter::ENCODING)
        CSV.open(output_path, "wb") do |output|
          output << %w{ Date Payee Category Memo Outflow Inflow }
          file.each do |row|
            output << rewriter.new(row).to_ynab
          end
        end
      rescue Encoding::InvalidByteSequenceError => e
        puts e.message
      end

      def print_preview
        puts Terminal::Table.new(rows: csv_output)
      end

      def csv_output
        CSV.read(output_path, headers: true, encoding: "UTF-8").to_a
      end

      def output_path
        "#{rewriter_name}.csv"
      end

      def rewriter_name
        rewriter.to_s.split(":").last.downcase
      end

      def remove_input_file
        FileUtils.rm(input_path)
      end
  end
end
