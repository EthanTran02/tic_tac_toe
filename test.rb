 # rubocop:disable Lint/EmptyFile,Lint/MissingCopEnableDirective,Layout/CommentIndentation,Lint/RedundantCopDisableDirective

new_array = Array.new(3) { Array.new(3, '_') }

new_array.each do |row|
  puts row.join(' | ')
end
