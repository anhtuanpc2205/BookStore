using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class Format
{
    public int FormatId { get; set; }

    public string FormatName { get; set; } = null!;

    public virtual ICollection<BookDetail> BookDetails { get; set; } = new List<BookDetail>();
}
