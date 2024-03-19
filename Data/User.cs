using System;
using System.Collections.Generic;

namespace BookStore.Data;

public partial class User
{
    public int UserId { get; set; }

    public string UserName { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string? ShippingAddress { get; set; }

    public byte Role { get; set; }

    public string? ProfileImageUrl { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<UserWishlist> UserWishlists { get; set; } = new List<UserWishlist>();
}
