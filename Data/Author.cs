using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class Author
{
    public int AuthorId { get; set; }

    public string AuthorName { get; set; } = null!;

    public string? Description { get; set; }

    public string? ProfileImageUrl { get; set; }

    public virtual ICollection<Blog> Blogs { get; set; } = new List<Blog>();

    public virtual ICollection<Book> Books { get; set; } = new List<Book>();
}
