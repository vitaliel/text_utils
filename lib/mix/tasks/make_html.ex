defmodule Mix.Tasks.MakeHtml do
  use Mix.Task
  use Phoenix.HTML

  @shortdoc "Make html page with chapter in two languages"
  def run(args) do
    [path_a, path_b | _] = args
    {:ok, data_a} = File.read(path_a)
    {:ok, data_b} = File.read(path_b)

    blocks_a = TextUtils.asciidoc_blocks(data_a)
    blocks_b = TextUtils.asciidoc_blocks(data_b)

    size_a = Enum.count(blocks_a)
    size_b = Enum.count(blocks_b)

    if size_a != size_b do
      IO.puts("Numbers of blocks differs: #{size_a} - #{size_b}")
    end

    tuples = List.zip([blocks_a, blocks_b])

    rows =
      List.foldl(tuples, [], fn el, acc ->
        {pa, pb} = el
        {:safe, txt_a} = html_escape(pa)
        {:safe, txt_b} = html_escape(pb)

        tags = """
        <tr>
          <td>#{txt_a}</td>
          <td>#{txt_b}</td>
        </tr>
        """

        acc ++ [tags]
      end)

    {:ok, tmpl} = File.read("tmpl/compare.html")

    html = String.replace(tmpl, "{{ROWS}}", Enum.join(rows, "\n"))
    File.write("compare.html", html)
  end
end
