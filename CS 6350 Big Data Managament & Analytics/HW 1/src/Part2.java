
import java.io.IOException;



import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.Reducer.Context;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;



import java.util.HashMap;

public class Part2 {
	
	public static class Map1 extends Mapper<LongWritable,Text,Text,Text>
	{
	
		String pair="";
	
		public void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException
		{
			String[] line = value.toString().split("\t");
			if(line.length==2)
			{
				int personA = Integer.parseInt(line[0]);
				String[] friends =line[1].split(",");
				for(String friend:friends)
				{
				
					int personB=Integer.parseInt(friend);
					if(personA <= personB)
					{
						pair=personA + "," + personB;
					}
					else
					{
						pair=personB + "," + personA;
					}
					context.write(new Text(pair), new Text(line[1]));
				
				
				}
			}
		}
	}
	
	
	public static class Reduce1 extends Reducer<Text,Text,Text,Text>
	{
		Text result=new Text();
		public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException
		{
			HashMap<String, Integer> map=new HashMap<String, Integer>();
			StringBuilder mutualFriends=new StringBuilder();
			int count=0;
			for(Text value : values)
			{
				String[] friends=value.toString().split(",");
				for(String friend : friends)
				{
					if(map.containsKey(friend))
					{
						mutualFriends.append(friend + ',');
						count++;
					}
					else
					{
						map.put(friend,1);
					}
				}
			}
			
			if (mutualFriends.lastIndexOf(",") > -1)
			{
				
				mutualFriends.deleteCharAt(mutualFriends.lastIndexOf(","));
			}
			result.set(new Text(mutualFriends.toString()));
			context.write(key, new Text(count+"\t"+mutualFriends));
		}
		
	}
	
	
	public static class Map2 extends Mapper<LongWritable,Text,IntWritable,Text>
	{
		public void map(LongWritable key,Text value,Context context) throws IOException,InterruptedException
		{
			String line[]=value.toString().split("\t");
			if(line.length==3)
			{
				context.write(new IntWritable(-1*Integer.parseInt(line[1])), new Text(line[0]+"\t"+line[1]+"\t"+line[2]));
				}
			}
		
	}

	
	public static class Reduce2 extends Reducer<IntWritable,Text,Text,Text>
	{
		int count=0;
		public void reduce(IntWritable key,Iterable<Text> values,Context context) throws IOException,InterruptedException
		{
			for (Text value:values)
			{
				if(count<10)
				{
					String[] line=value.toString().split("\t");
					context.write(new Text(line[0]),new Text(line[1]+"\t"+line[2]));
					count++;
				}
				else
				{
					break;
				}
			}
		}
		
		
	}
	
	
	

	
	public static void main(String args[]) throws Exception
	{
		
		Configuration confA=new Configuration();
		String[] otherargs=new GenericOptionsParser(confA,args).getRemainingArgs();
	
		
		Job jobA = Job.getInstance(confA,"Top Ten Number of Mutual Friends Stage 1");
		jobA.setJarByClass(Part2.class);
		jobA.setMapperClass(Map1.class);
		jobA.setReducerClass(Reduce1.class);
		
		jobA.setMapOutputKeyClass(Text.class);
		jobA.setMapOutputValueClass(Text.class);
		jobA.setOutputKeyClass(Text.class);
		jobA.setOutputValueClass(Text.class);
		
		FileInputFormat.addInputPath(jobA,new Path(otherargs[0]));
		FileOutputFormat.setOutputPath(jobA, new Path(otherargs[1]));
		boolean mapreduce=jobA.waitForCompletion(true);
		
		
		if(mapreduce)
		{
			Configuration confB=new Configuration();
			
			Job jobB = Job.getInstance(confB,"Top Ten Number of Mutual Friends Stage 2");
			jobB.setJarByClass(Part2.class);
			
			jobB.setInputFormatClass(TextInputFormat.class);
			jobB.setMapperClass(Map2.class);
			jobB.setReducerClass(Reduce2.class);
			
			jobB.setMapOutputKeyClass(IntWritable.class);
			jobB.setMapOutputValueClass(Text.class);
			jobB.setOutputKeyClass(IntWritable.class);
			jobB.setOutputValueClass(Text.class);
			FileInputFormat.addInputPath(jobB,new Path(otherargs[1]));
			FileOutputFormat.setOutputPath(jobB, new Path(otherargs[2]));
			System.exit(jobB.waitForCompletion(true) ? 0:1);
		}
		}
	}


