//
//  HRPGRewardTableViewCell.m
//  Habitica
//
//  Created by Phillip Thelen on 13/09/15.
//  Copyright © 2017 HabitRPG Inc. All rights reserved.
//

#import "HRPGRewardTableViewCell.h"
#import "NSString+Emoji.h"
#import "UIColor+Habitica.h"
#import "NSString+StripHTML.h"
#import "Habitica-Swift.h"

@interface HRPGRewardTableViewCell ()

@property(nonatomic, copy) void (^tapAction)();

@end

@implementation HRPGRewardTableViewCell

- (void)configureForReward:(MetaReward *)reward withGoldOwned:(NSNumber *)gold {
    self.buyView.layer.borderWidth = 1.0;
    self.buyView.layer.cornerRadius = 5.0;

    self.titleLabel.text = [reward.text stringByReplacingEmojiCheatCodesWithUnicode];
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    if (reward.notes && reward.notes.length > 0) {
        self.detailLabel.text = [reward.notes stringByReplacingEmojiCheatCodesWithUnicode];
        self.detailLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        self.titleNotesConstraint.constant = 4.0;
    } else {
        self.detailLabel.text = nil;
        self.titleNotesConstraint.constant = 0;
    }

    self.priceLabel.text = [reward.value stringValue];
    self.priceLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    if (self.buyButton.gestureRecognizers.count == 0) {
        UITapGestureRecognizer *tapGestureRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBuyTap:)];
        [self.buyButton addGestureRecognizer:tapGestureRecognizer];
    }
    self.coinImageView.image = HabiticaIcons.imageOfGold;

    if ([gold floatValue] > [reward.value floatValue]) {
        self.buyView.layer.borderColor = [[UIColor purple300] CGColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.detailLabel.textColor = [UIColor gray50];
        self.priceLabel.textColor = [UIColor purple300];
        self.imageView.alpha = 1.0;
        self.coinImageView.alpha = 1.0;
        self.backgroundColor = [UIColor whiteColor];
        self.buyButton.userInteractionEnabled = YES;
    } else {
        self.buyView.layer.borderColor = [[UIColor gray100] CGColor];
        self.titleLabel.textColor = [UIColor gray100];
        self.detailLabel.textColor = [UIColor gray100];
        self.priceLabel.textColor = [UIColor gray100];
        self.imageView.alpha = 0.6;
        self.coinImageView.alpha = 0.6;
        self.backgroundColor = [UIColor gray700];
        self.buyButton.userInteractionEnabled = NO;
    }
}

- (void)configureForShopItem:(ShopItem *)shopItem withCurrencyOwned:(NSNumber *)currencyAmount {
    self.buyView.layer.borderWidth = 1.0;
    self.buyView.layer.cornerRadius = 5.0;
    
    self.titleLabel.text = shopItem.text;
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    if (shopItem.notes && shopItem.notes.length > 0) {
        self.detailLabel.text = [shopItem.notes stringByStrippingHTML];
        self.detailLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        self.titleNotesConstraint.constant = 4.0;
    } else {
        self.detailLabel.text = nil;
        self.titleNotesConstraint.constant = 0;
    }
    
    self.priceLabel.text = [shopItem.value stringValue];
    self.priceLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    if (self.buyButton.gestureRecognizers.count == 0) {
        UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBuyTap:)];
        [self.buyButton addGestureRecognizer:tapGestureRecognizer];
    }
    if ([shopItem.currency isEqualToString:@"gems"]) {
        self.coinImageView.image = HabiticaIcons.imageOfGem;
    } else {
        self.coinImageView.image = HabiticaIcons.imageOfGold;
    }
    
    if ([shopItem.category.purchaseAll boolValue] || shopItem.unlockCondition) {
        self.buyButton.hidden = YES;
    } else {
        self.buyButton.hidden = NO;
    }
    
    if ([shopItem.currency isEqualToString:@"gems"] || [shopItem canBuy:currencyAmount]) {
        self.buyView.layer.borderColor = [[UIColor purple300] CGColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.detailLabel.textColor = [UIColor gray50];
        self.priceLabel.textColor = [UIColor purple300];
        self.imageView.alpha = 1.0;
        self.coinImageView.alpha = 1.0;
        self.backgroundColor = [UIColor whiteColor];
        self.buyButton.userInteractionEnabled = YES;
    } else {
        self.buyView.layer.borderColor = [[UIColor gray100] CGColor];
        self.titleLabel.textColor = [UIColor gray100];
        self.detailLabel.textColor = [UIColor gray100];
        self.priceLabel.textColor = [UIColor gray100];
        self.imageView.alpha = 0.6;
        self.coinImageView.alpha = 0.6;
        self.backgroundColor = [UIColor gray700];
        self.buyButton.userInteractionEnabled = NO;
    }
    
    if (shopItem.itemsLeft && [shopItem.isSubscriberItem boolValue]) {
        self.itemsLeftLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ left", nil), shopItem.itemsLeft];
        self.itemLeftSpacing.constant = 4;
    } else {
        self.itemsLeftLabel.text = nil;
        self.itemLeftSpacing.constant = 0;
    }
}

- (void)handleBuyTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (self.tapAction) {
            self.tapAction();
        }
        [UIView animateWithDuration:0.15
            animations:^() {
                self.buyView.backgroundColor = [UIColor purple300];
            }
            completion:^(BOOL completed) {
                [UIView animateWithDuration:0.15
                                      delay:0.15
                                    options:UIViewAnimationOptionAllowUserInteraction
                                 animations:^() {
                                     self.buyView.backgroundColor = [UIColor clearColor];
                                 }
                                 completion:nil];
            }];
    }
}

- (void)onPurchaseTap:(void (^)())actionBlock {
    self.tapAction = actionBlock;
}

@end
