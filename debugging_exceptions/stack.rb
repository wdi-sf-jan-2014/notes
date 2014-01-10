$calls = 0
  def infinite
    $calls += 1
    infinite
  end
begin
  infinite
ensure
  puts $calls
end
