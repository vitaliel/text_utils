defmodule Mix.Tasks.RunConvert do
  use Mix.Task

  @shortdoc "Wrap lines in text file by 80 chars"
  def run(args) do
    [input, output | _] = args
    {:ok, data} = File.read(input)
    new_data = TextUtils.wrap(data)
    :ok = File.write(output, new_data)
  end
end
