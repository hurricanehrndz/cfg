local has_comment, comment = pcall(require, "comment")

if not has_comment then
  return
end

comment.setup()
