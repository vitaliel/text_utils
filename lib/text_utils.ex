defmodule TextUtils do
  @moduledoc """
  TextUtils has wrap text to 80 chars function.
  """

  def wrap(text, size \\ 80) do
    blocks = String.split(text, ~r/\n{2,}/)

    new_text =
      List.foldl(blocks, [], fn el, acc ->
        new_block = wrap_para(el, size)
        acc ++ [new_block]
      end)
      |> Enum.join("\n\n")

    if has_eol?(text) && !has_eol?(new_text) do
      new_text <> "\n"
    else
      new_text
    end
  end

  # It does not change asciidoc lists, special block, headers
  def wrap_para(text, size) do
    if String.starts_with?(text, ["*", "[", "="]) do
      text
    else
      [first | words] = String.trim(text) |> String.split(~r/\s+/)

      result =
        List.foldl(words, %{lines: [], line: first}, fn el, acc ->
          line = acc.line

          if String.length(line) + String.length(el) + 1 > size do
            new_lines = acc.lines ++ [line]
            %{line: el, lines: new_lines}
          else
            %{acc | line: "#{line} #{el}"}
          end
        end)

      lines =
        if String.length(result.line) > 0 do
          result.lines ++ [result.line]
        else
          result.lines
        end

      new_text = Enum.join(lines, "\n")

      if has_eol?(text) do
        new_text <> "\n"
      else
        new_text
      end
    end
  end

  #  @doc """
  #  Hello world.
  #
  #  ## Examples
  #
  #      iex> TextUtils.hello
  #      :world
  #
  #  """
  #  def hello do
  #    :world
  #  end

  defp has_eol?(txt) do
    String.ends_with?(txt, "\n")
  end
end
