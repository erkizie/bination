module Lib
  # Base Connection Class
  class BaseConnection < GraphQL::Types::Relay::BaseConnection

    field :total_count, Integer, null: false
    field :total_page_count, Integer, null: false

    def total_count
      object.nodes.size
    end

    def total_page_count
      # TODO: maybe to refactor somehow?
      return 1 unless object.nodes.count.positive?

      # get total count and create array with total count as first item
      my_total_count = object.nodes.count
      possible_page_sizes = [my_total_count]

      # add first and last argument counts to the array if they exist
      possible_page_sizes.push(object.arguments[:first]) if object.arguments[:first]
      possible_page_sizes.push(object.arguments[:last]) if object.arguments[:last]

      # get the smallest of the array items
      actual_page_size = possible_page_sizes.min

      # return the total_count divided by the page size, rounded up
      (my_total_count / actual_page_size.to_f).ceil
    end
  end
end
