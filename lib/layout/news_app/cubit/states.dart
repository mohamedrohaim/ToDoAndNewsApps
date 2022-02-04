abstract class NewsStates {}
class NewsInitialState extends NewsStates{}
class NewsBottomNavState extends NewsStates{}
class NewsBusinessLoadingState extends NewsStates{}
class NewsgetBusinessSuccesState extends NewsStates{}
class NewsgetBusinessErorState extends NewsStates
{
  final String error;
  NewsgetBusinessErorState(this.error);
}

class NewsSportsLoadingState extends NewsStates{}
class NewsgetSportsSuccesState extends NewsStates{}
class NewsgetSportsErorState extends NewsStates
{
  final String error;
  NewsgetSportsErorState(this.error);
}

class NewsScienceLoadingState extends NewsStates{}
class NewsgetScienceSuccesState extends NewsStates{}
class NewsgetScienceErorState extends NewsStates
{
  final String error;
  NewsgetScienceErorState(this.error);
}
