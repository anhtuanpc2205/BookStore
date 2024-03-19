using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class OrderDetail
{
    public int OrderDetailId { get; set; }

    public int OrderId { get; set; }

    public int BookDetailId { get; set; }

    public int Quantity { get; set; }

    public virtual BookDetail BookDetail { get; set; } = null!;

    public virtual Order Order { get; set; } = null!;
}
