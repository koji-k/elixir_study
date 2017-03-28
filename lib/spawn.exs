#spawn_link fn -> raise "oops" end
spawn_link fn -> :hello end
receive do
  :hello -> "let's wait until the process failse"
end
