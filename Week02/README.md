# Week 02

## Struct Vs. Class

I read up on the "Which one to use?" section of the [RW Swift Style Guide](https://github.com/raywenderlich/swift-style-guide#which-one-to-use)  to help with my decision of choosing between a class type vs. a struct type. I had the idea of using a struct at first, since to me BullsEyeGame didn't seem to have an identity (at first). Then it led me on a 15-minute meditation on what identity really meant... :]

So, I tried giving BullsEyeGame a struct type. However, I noticed some compilation errors as I started to implement the model. I almost forgot how structs are immutable types. I also liked the idea of how classes are called-by-reference. Since there was only one BullsEyeGame in existence, I didn't need to worry about doing a deep copy in any situation. Because of this, I decided that in the end it would be a lot more fluid to work with a class type.
