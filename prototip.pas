program BookCatalog;

type
  tbook = record
    author: string;
    title: string;
    publisher: string;
    year: integer;
  end;

var
  books: array of tbook;
  bookcount: integer;

procedure readbooksfromfile;
var
  f: Text;
  i: integer;
begin
  assign(f, 'books.txt');
  try
    reset(f);
    bookcount := 0;
    setlength(books, 1000);
    
    while not Eof(f) and (BookCount < 1000) do
    begin
      bookCount := bookcount + 1;
      readln(f, books[bookcount-1].author);
      readln(f, books[bookcount-1].title);
      readln(f, books[bookcount-1].publisher);
      readln(f, books[bookcount-1].year);
    end;
    
    setlength(books, bookcount);
    close(f);
    writeln('Загружено книг: ', bookcount);
  except
    on System.IO.FileNotFoundException do
      writeln('Файл books.txt не найден');
    on e: Exception do
      writeln('Ошибка при чтении файла: ', e.Message);
  end;
end;

procedure findbooksbypublisherandyear;
var
  i: integer;
  pub: string;
  year: integer;
  found: boolean;
begin
  if bookcount = 0 then
  begin
    writeln('Каталог книг пуст!');
    exit;
  end;

  write('Введите издательство: ');
  readln(pub);
  write('Введите год издания: ');
  readln(year);
  
  found := False;
  for i := 0 to bookcount-1 do
  begin
    if (books[i].publisher = pub) and (books[i].year = year) then
    begin
      writeln('Найдена книга: "', books[i].title, '" - ', books[i].author);
      found := True;
    end;
  end;
  
  if not found then
    writeln('Книги не найдены.');
end;

procedure findauthorsbypublisher;
var
  i, j: integer;
  pub: string;
  authors: array of string;
  authorcount: integer;
  exists: boolean;
begin
  if bookcount = 0 then
  begin
    writeln('Каталог книг пуст!');
    exit;
  end;

  write('Введите издательство: ');
  readln(pub);
  
  authorcount := 0;
  setlength(authors, bookcount);
  
  for i := 0 to bookcount-1 do
  begin
    if books[i].publisher = pub then
    begin
      exists := False;
      for j := 0 to authorcount-1 do
      begin
        if authors[j] = books[i].author then
        begin
          exists := True;
          break;
        end;
      end;
      
      if not exists then
      begin
        authors[authorcount] := books[i].author;
        authorcount := authorcount + 1;
      end;
    end;
  end;
  
  if authorcount > 0 then
  begin
    writeln('Найдены авторы издательства "', pub, '":');
    for i := 0 to authorcount-1 do
      writeln(authors[i]);
  end
  else
    writeln('Авторы не найдены.');
end;

begin
  readbooksfromfile;
  
  while True do
  begin
    writeln;
    writeln('Главное меню:');
    writeln('1. Поиск книг по издательству и году');
    writeln('2. Поиск авторов издательства');
    writeln('3. Выход');
    Write('Выберите действие 1, 2 или 3: ');
    
    var choice: integer;
    readln(choice);
    
    case choice of
      1: findbooksbypublisherandyear;
      2: findauthorsbypublisher;
      3: break;
    else
      writeln('Неверный выбор!');
    end;
  end;
end.