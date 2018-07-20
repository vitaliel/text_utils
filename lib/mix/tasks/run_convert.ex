defmodule Mix.Tasks.RunConvert do
  use Mix.Task

  @shortdoc "Wrap lines in text file by 80 chars"
  def run(args) do
    # IO.puts IO.inspect(args)
    # [file | _] = args
    file = "cap00.adoc"
    {:ok, data} = File.read(file)
    new_data = TextUtils.wrap(data)
    IO.puts(new_data)
  end
end
