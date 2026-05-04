trigger RatingUpdate on Account (before insert) {
    For(Account acc: trigger.new){
        if (acc.Site == 'India'){
            acc.Rating ='Hot';
        }
    }
}